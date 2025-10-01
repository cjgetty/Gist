import Foundation

public protocol AuthServiceProtocol {
    func signInWithAppleStub() async throws -> User
    func signOut() async
    // Token refresh stub used by NetworkClient on 401 responses
    func refreshAuthTokenIfNeeded() async throws -> String?
}

public extension AuthServiceProtocol {
    func refreshAuthTokenIfNeeded() async throws -> String? { nil }
}

public final class AuthService: AuthServiceProtocol {
    public init() {}
    public func signInWithAppleStub() async throws -> User { MockData.sampleUser }
    public func signOut() async {}
    public func refreshAuthTokenIfNeeded() async throws -> String? {
        // Stubbed token refresh: in a real app, exchange refresh token for new access token
        return "refreshed-token"
    }
}

public final class MockAuthService: AuthServiceProtocol {
    public init() {}
    public func signInWithAppleStub() async throws -> User { MockData.sampleUser }
    public func signOut() async {}
    public func refreshAuthTokenIfNeeded() async throws -> String? { "mock-token" }
}
