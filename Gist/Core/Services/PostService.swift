import Foundation

public protocol PostServiceProtocol {
    func createPost(_ post: Post) async throws -> Post
    func vote(postId: UUID, value: Int) async throws -> Vote
}

public final class PostService: PostServiceProtocol {
    private let client: NetworkClientProtocol
    public init(client: NetworkClientProtocol) { self.client = client }
    public func createPost(_ post: Post) async throws -> Post { post }
    public func vote(postId: UUID, value: Int) async throws -> Vote {
        Vote(userId: MockData.sampleUser.id, targetType: .post, targetId: postId, value: value)
    }
}

public final class MockPostService: PostServiceProtocol {
    public init() {}
    public func createPost(_ post: Post) async throws -> Post { post }
    public func vote(postId: UUID, value: Int) async throws -> Vote {
        Vote(userId: MockData.sampleUser.id, targetType: .post, targetId: postId, value: value)
    }
}
