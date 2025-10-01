import Foundation
import Combine

@MainActor
public final class ModerationViewModel: ObservableObject {
    @Published public private(set) var state = ModerationUIState()
    private let service: ModerationServiceProtocol
    public init(service: ModerationServiceProtocol = AppContainer.shared.moderationService) {
        self.service = service
        Task { await load() }
    }
    public func load() async {
        do { state.queue = try await service.fetchQueue() } catch { state.queue = [] }
    }
}
