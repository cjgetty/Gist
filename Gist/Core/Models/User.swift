import Foundation

public struct User: Identifiable, Codable, Equatable {
    public let id: UUID
    public var email: String?
    public var createdAt: Date
}
