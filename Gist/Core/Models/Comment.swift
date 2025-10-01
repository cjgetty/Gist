import Foundation

public struct Comment: Identifiable, Codable, Equatable {
    public let id: UUID
    public var postId: UUID
    public var parentId: UUID?
    public var authorUserId: UUID?
    public var identityMode: IdentityMode
    public var bodyMD: String
    public var score: Int
    public var createdAt: Date
}
