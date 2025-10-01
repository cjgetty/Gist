import Foundation
import Combine
import GistCore

@MainActor
public final class CommunityViewModel: ObservableObject {
    @Published public private(set) var state = CommunityUIState()
    private let service: CommunityServiceProtocol
    public init(service: CommunityServiceProtocol = AppContainer.shared.communityService) {
        self.service = service
    }
    public func toggleMembership() async {
        state.isMember.toggle()
    }
}
