import Foundation

public protocol FeedServiceProtocol {
    func fetchHomeFeed() async throws -> [Post]
}

public final class FeedService: FeedServiceProtocol {
    private let client: NetworkClientProtocol
    public init(client: NetworkClientProtocol) { self.client = client }
    public func fetchHomeFeed() async throws -> [Post] {
        // return try await client.get("/feed/home")
        return MockData.samplePosts
    }
}

public final class MockFeedService: FeedServiceProtocol {
    public init() {}
    public func fetchHomeFeed() async throws -> [Post] { MockData.samplePosts }
}
