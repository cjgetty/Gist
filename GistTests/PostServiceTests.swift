import XCTest
@testable import GistCore

final class PostServiceTests: XCTestCase {
    func testCreatePostReturnsInput() async throws {
        let service: PostServiceProtocol = MockPostService()
        let newPost = Post(
            id: UUID(),
            communityId: MockData.sampleCommunities[0].id,
            authorUserId: MockData.sampleUser.id,
            identityMode: .public,
            title: "Hello",
            bodyMD: "World",
            mediaURLs: [],
            score: 0,
            createdAt: Date()
        )
        let created = try await service.createPost(newPost)
        XCTAssertEqual(created.title, newPost.title)
        XCTAssertEqual(created.identityMode, .public)
    }

    func testVoteUpAndDown() async throws {
        let service: PostServiceProtocol = MockPostService()
        let postId = UUID()
        let upvote = try await service.vote(postId: postId, value: 1)
        XCTAssertEqual(upvote.value, 1)
        XCTAssertEqual(upvote.targetType, .post)
        XCTAssertEqual(upvote.targetId, postId)

        let downvote = try await service.vote(postId: postId, value: -1)
        XCTAssertEqual(downvote.value, -1)
    }

    func testIdentityModeAnonymous() async throws {
        // Ensure identity mode values round-trip through our model
        let p = Post(
            id: UUID(),
            communityId: MockData.sampleCommunities[1].id,
            authorUserId: nil,
            identityMode: .anonymous,
            title: "Anon",
            bodyMD: "Secret",
            mediaURLs: [],
            score: 0,
            createdAt: Date()
        )
        XCTAssertEqual(p.identityMode, .anonymous)
    }
}
