import XCTest
@testable import GistCore

private final class TestURLProtocol: URLProtocol {
    struct ResponsePlan {
        var statusCodes: [Int]
        var payloads: [Data]
        var error: URLError?
        var index: Int = 0
    }

    static var plan: ResponsePlan?

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        guard let client = client else { return }
        if let error = Self.plan?.error {
            client.urlProtocol(self, didFailWithError: error)
            return
        }
        guard var plan = Self.plan, plan.index < plan.statusCodes.count, plan.index < plan.payloads.count else {
            client.urlProtocol(self, didFailWithError: URLError(.badServerResponse))
            return
        }
        let status = plan.statusCodes[plan.index]
        let data = plan.payloads[plan.index]
        plan.index += 1
        Self.plan = plan
        let url = request.url ?? URL(string: "https://example.com")!
        let response = HTTPURLResponse(url: url, statusCode: status, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
        client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client.urlProtocol(self, didLoad: data)
        client.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}

final class NetworkClientFailureTests: XCTestCase {
    private func session() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [TestURLProtocol.self]
        return URLSession(configuration: config)
    }

    func testTimeoutMapsToTimeoutError() async {
        let s = session()
        TestURLProtocol.plan = .init(statusCodes: [], payloads: [], error: URLError(.timedOut))
        let client = NetworkClient(baseURL: EnvironmentConfig.apiBaseURL, session: s)
        do {
            let _: Post = try await client.get("/posts/1")
            XCTFail("Expected timeout")
        } catch let e as NetworkError {
            XCTAssertEqual(e, .timeout)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testUnauthorizedRefreshThenSuccess() async throws {
        let s = session()
        let post = MockData.samplePosts[0]
        let okPayload = try JSONEncoder().encode(post)
        TestURLProtocol.plan = .init(statusCodes: [401, 200], payloads: [Data(), okPayload], error: nil)
        let auth = MockAuthService()
        let client = NetworkClient(baseURL: EnvironmentConfig.apiBaseURL, session: s, tokenProvider: { nil }, authService: auth)
        let got: Post = try await client.get("/posts/1")
        XCTAssertEqual(got.id, post.id)
    }

    func testDecodingFailureMapsToDecoding() async {
        let s = session()
        let badJSON = Data("{".utf8)
        TestURLProtocol.plan = .init(statusCodes: [200], payloads: [badJSON], error: nil)
        let client = NetworkClient(baseURL: EnvironmentConfig.apiBaseURL, session: s)
        do {
            let _: Post = try await client.get("/posts/1")
            XCTFail("Expected decoding error")
        } catch let e as NetworkError {
            XCTAssertEqual(e, .decoding)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
