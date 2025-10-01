import XCTest
@testable import GistCore

final class ModerationServiceTests: XCTestCase {
    func testReportDoesNotThrow() async throws {
        let service: ModerationServiceProtocol = MockModerationService()
        try await service.report(targetId: UUID(), reason: "spam")
        XCTAssertTrue(true)
    }

    func testFetchQueueReturnsStubbedItems() async throws {
        let service: ModerationServiceProtocol = MockModerationService()
        let items = try await service.fetchQueue()
        XCTAssertFalse(items.isEmpty)
        XCTAssertTrue(items.contains(where: { $0.lowercased().contains("spam") }))
    }
}
