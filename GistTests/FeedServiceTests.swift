import XCTest
@testable import GistCore

final class FeedServiceTests: XCTestCase {
    func testFeedServiceReturnsMockPosts() async throws {
        let service = MockFeedService()
        let posts = try await service.fetchHomeFeed()
        XCTAssertFalse(posts.isEmpty)
        XCTAssertEqual(posts[0].title, MockData.samplePosts[0].title)
    }
}
