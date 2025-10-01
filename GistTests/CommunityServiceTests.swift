import XCTest
@testable import GistCore

final class CommunityServiceTests: XCTestCase {
    func testFetchTrendingCommunitiesReturnsMockData() async throws {
        let service: CommunityServiceProtocol = MockCommunityService()
        let trending = try await service.fetchTrendingCommunities()
        XCTAssertFalse(trending.isEmpty)
        XCTAssertEqual(trending, MockData.sampleCommunities)
    }

    func testJoinAndLeaveCommunityDoNotThrow() async throws {
        let service: CommunityServiceProtocol = MockCommunityService()
        let id = MockData.sampleCommunities[0].id
        try await service.join(communityId: id)
        try await service.leave(communityId: id)
        XCTAssertTrue(true)
    }
}
