import Foundation
import Combine
import GistCore

@MainActor
public final class ComposerViewModel: ObservableObject {
    @Published public var state = ComposerUIState()
    private let postService: PostServiceProtocol
    public init(postService: PostServiceProtocol = AppContainer.shared.postService) {
        self.postService = postService
    }
    public func submit() async {
        // stub submission
    }
}
