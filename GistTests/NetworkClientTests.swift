import XCTest
@testable import GistCore

final class NetworkClientTests: XCTestCase {
    func testMockNetworkClientDecodesModel() async throws {
        let expected = Post(
            id: UUID(),
            communityId: UUID(),
            authorUserId: nil,
            identityMode: .anonymous,
            title: "Test",
            bodyMD: "Body",
            mediaURLs: [],
            score: 1,
            createdAt: Date()
        )
        let client = MockNetworkClient { method, path, body in
            XCTAssertEqual(method, "GET")
            XCTAssertEqual(path, "/posts/1")
            return try JSONEncoder().encode(expected)
        }
        let result: Post = try await client.get("/posts/1")
        XCTAssertEqual(result.title, expected.title)
        XCTAssertEqual(result.identityMode, .anonymous)
    }
}
