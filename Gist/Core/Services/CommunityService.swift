import Foundation

public protocol CommunityServiceProtocol {
    func fetchTrendingCommunities() async throws -> [Community]
    func join(communityId: UUID) async throws
    func leave(communityId: UUID) async throws
}

public final class CommunityService: CommunityServiceProtocol {
    private let client: NetworkClientProtocol
    public init(client: NetworkClientProtocol) { self.client = client }
    public func fetchTrendingCommunities() async throws -> [Community] { MockData.sampleCommunities }
    public func join(communityId: UUID) async throws {}
    public func leave(communityId: UUID) async throws {}
}

public final class MockCommunityService: CommunityServiceProtocol {
    public init() {}
    public func fetchTrendingCommunities() async throws -> [Community] { MockData.sampleCommunities }
    public func join(communityId: UUID) async throws {}
    public func leave(communityId: UUID) async throws {}
}
