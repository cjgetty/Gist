import Foundation

public struct Post: Identifiable, Codable, Equatable {
    public let id: UUID
    public var communityId: UUID
    public var authorUserId: UUID?
    public var identityMode: IdentityMode
    public var title: String
    public var bodyMD: String
    public var mediaURLs: [URL]
    public var score: Int
    public var createdAt: Date
}
