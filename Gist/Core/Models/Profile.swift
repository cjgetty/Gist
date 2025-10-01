import Foundation

public struct Profile: Identifiable, Codable, Equatable {
    public let id: UUID
    public var userId: UUID
    public var displayName: String
    public var avatarURL: URL?
    public var bio: String
    public var privacyLevel: String
}
