import Foundation
import GistCore

public struct ProfileUIState: Equatable {
    public var profile = Profile(id: UUID(), userId: UUID(), displayName: "User", avatarURL: nil, bio: "", privacyLevel: "Public")
}
