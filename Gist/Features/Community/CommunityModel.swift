import Foundation
import GistCore

public struct CommunityUIState: Equatable {
    public var community: Community = MockData.sampleCommunities[0]
    public var isMember: Bool = false
}
