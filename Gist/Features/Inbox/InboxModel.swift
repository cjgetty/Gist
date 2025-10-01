import Foundation

public struct InboxItem: Identifiable, Equatable {
    public let id: UUID
    public let text: String
    public let createdAt: Date
}

public struct InboxUIState: Equatable {
    public var items: [InboxItem] = []
}
