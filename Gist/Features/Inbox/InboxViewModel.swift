import Foundation
import Combine
import GistCore

@MainActor
public final class InboxViewModel: ObservableObject {
    @Published public private(set) var state = InboxUIState()
    public init() {
        state.items = MockData.sampleNotifications.map { InboxItem(id: UUID(), text: $0, createdAt: Date()) }
    }
}
