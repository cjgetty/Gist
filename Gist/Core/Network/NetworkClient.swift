import Foundation

public protocol NetworkClientProtocol {
    func get<T: Decodable>(_ path: String) async throws -> T
    func post<T: Decodable, U: Encodable>(_ path: String, body: U) async throws -> T
    func put<T: Decodable, U: Encodable>(_ path: String, body: U) async throws -> T
    func delete<T: Decodable>(_ path: String) async throws -> T
}

public enum NetworkError: Error, Equatable {
    case invalidURL
    case http(Int)
    case unauthorized
    case timeout
    case decoding
    case maxRetriesReached
    case other
}

public final class NetworkClient: NetworkClientProtocol {
    private let baseURL: URL
    private let session: URLSession
    private let tokenProvider: () -> String?
    private let authService: AuthServiceProtocol?
    private let maxRetries: Int
    private let retryDelay: (Int) -> UInt64 // attempt -> nanoseconds

    public init(
        baseURL: URL,
        session: URLSession = .shared,
        tokenProvider: @escaping () -> String? = { nil },
        authService: AuthServiceProtocol? = nil,
        maxRetries: Int = 2,
        retryDelay: @escaping (Int) -> UInt64 = { attempt in
            // 0.25s, 0.5s, 1.0s ...
            let base: Double = 0.25
            return UInt64((base * pow(2.0, Double(attempt))) * 1_000_000_000)
        }
    ) {
        self.baseURL = baseURL
        self.session = session
        self.tokenProvider = tokenProvider
        self.authService = authService
        self.maxRetries = maxRetries
        self.retryDelay = retryDelay
    }

    private func makeRequest<U: Encodable>(method: String, url: URL, body: U?, overrideToken: String?) throws -> URLRequest {
        var req = URLRequest(url: url)
        req.httpMethod = method
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        let token = overrideToken ?? tokenProvider()
        if let token = token { req.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization") }
        if let body = body {
            req.httpBody = try JSONEncoder().encode(body)
            req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return req
    }

    private func request<T: Decodable, U: Encodable>(_ method: String, _ path: String, body: U? = nil) async throws -> T {
        guard let url = URL(string: path, relativeTo: baseURL) else { throw NetworkError.invalidURL }

        var attempt = 0
        var didRefresh = false
        var overrideToken: String? = nil

        while true {
            do {
                let req = try makeRequest(method: method, url: url, body: body, overrideToken: overrideToken)
                let (data, resp) = try await session.data(for: req)
                if let http = resp as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
                    if http.statusCode == 401 {
                        if !didRefresh, let auth = authService, let newToken = try await auth.refreshAuthTokenIfNeeded() {
                            didRefresh = true
                            overrideToken = newToken
                            continue // retry immediately with refreshed token
                        }
                        throw NetworkError.unauthorized
                    }
                    if (500...599).contains(http.statusCode) || http.statusCode == 429 {
                        // transient -> retry if attempts remain
                        if attempt < maxRetries {
                            try await Task.sleep(nanoseconds: retryDelay(attempt))
                            attempt += 1
                            continue
                        }
                        throw NetworkError.maxRetriesReached
                    }
                    throw NetworkError.http(http.statusCode)
                }
                do { return try JSONDecoder().decode(T.self, from: data) } catch {
                    throw NetworkError.decoding
                }
            } catch {
                if let netErr = error as? NetworkError {
                    throw netErr
                }
                if let urlErr = error as? URLError {
                    if urlErr.code == .timedOut {
                        if attempt < maxRetries {
                            try await Task.sleep(nanoseconds: retryDelay(attempt))
                            attempt += 1
                            continue
                        }
                        throw NetworkError.timeout
                    }
                }
                // Non-retriable
                throw NetworkError.other
            }
        }
    }

    public func get<T>(_ path: String) async throws -> T where T : Decodable { try await request("GET", path, body: Optional<Data>.none) }
    public func post<T, U>(_ path: String, body: U) async throws -> T where T : Decodable, U : Encodable { try await request("POST", path, body: body) }
    public func put<T, U>(_ path: String, body: U) async throws -> T where T : Decodable, U : Encodable { try await request("PUT", path, body: body) }
    public func delete<T>(_ path: String) async throws -> T where T : Decodable { try await request("DELETE", path, body: Optional<Data>.none) }
}

public final class MockNetworkClient: NetworkClientProtocol {
    public typealias Handler = (_ method: String, _ path: String, _ body: Data?) throws -> Data
    private let handler: Handler
    public init(handler: @escaping Handler) { self.handler = handler }
    public func get<T>(_ path: String) async throws -> T where T : Decodable { try await decode(method: "GET", path: path, body: nil) }
    public func post<T, U>(_ path: String, body: U) async throws -> T where T : Decodable, U : Encodable { let b = try JSONEncoder().encode(body); return try await decode(method: "POST", path: path, body: b) }
    public func put<T, U>(_ path: String, body: U) async throws -> T where T : Decodable, U : Encodable { let b = try JSONEncoder().encode(body); return try await decode(method: "PUT", path: path, body: b) }
    public func delete<T>(_ path: String) async throws -> T where T : Decodable { try await decode(method: "DELETE", path: path, body: nil) }
    private func decode<T: Decodable>(method: String, path: String, body: Data?) async throws -> T {
        let data = try handler(method, path, body)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
