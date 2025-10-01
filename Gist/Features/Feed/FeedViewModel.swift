import Foundation
import Combine
import GistCore

@MainActor
public final class FeedViewModel: ObservableObject {
    @Published public private(set) var posts: [Post] = []
    @Published public var state = FeedUIState()
    private let service: FeedServiceProtocol
    public init(service: FeedServiceProtocol = AppContainer.shared.feedService) {
        self.service = service
    }
    public func load() async {
        state.isLoading = true
        defer { state.isLoading = false }
        do { posts = try await service.fetchHomeFeed() } catch { posts = [] }
    }
}
