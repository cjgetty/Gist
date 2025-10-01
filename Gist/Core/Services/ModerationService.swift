import Foundation

public protocol ModerationServiceProtocol {
    func report(targetId: UUID, reason: String) async throws
    func fetchQueue() async throws -> [String]
}

public final class ModerationService: ModerationServiceProtocol {
    private let client: NetworkClientProtocol
    public init(client: NetworkClientProtocol) { self.client = client }
    public func report(targetId: UUID, reason: String) async throws {}
    public func fetchQueue() async throws -> [String] { ["Report: spam", "Report: abuse"] }
}

public final class MockModerationService: ModerationServiceProtocol {
    public init() {}
    public func report(targetId: UUID, reason: String) async throws {}
    public func fetchQueue() async throws -> [String] { ["Report: spam", "Report: abuse"] }
}
