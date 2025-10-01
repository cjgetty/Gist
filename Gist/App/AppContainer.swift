import Foundation
import Combine
import GistCore

@MainActor
public final class AppContainer: ObservableObject {
    public static let shared: AppContainer = AppContainer.makeDefault()

    // Core services
    public let authService: AuthServiceProtocol
    public let networkClient: NetworkClientProtocol
    public let feedService: FeedServiceProtocol
    public let postService: PostServiceProtocol
    public let communityService: CommunityServiceProtocol
    public let moderationService: ModerationServiceProtocol
    public let haptics: HapticFeedbackServiceProtocol

    public init(
        authService: AuthServiceProtocol,
        networkClient: NetworkClientProtocol,
        feedService: FeedServiceProtocol,
        postService: PostServiceProtocol,
        communityService: CommunityServiceProtocol,
        moderationService: ModerationServiceProtocol,
        haptics: HapticFeedbackServiceProtocol
    ) {
        self.authService = authService
        self.networkClient = networkClient
        self.feedService = feedService
        self.postService = postService
        self.communityService = communityService
        self.moderationService = moderationService
        self.haptics = haptics
    }

    public static func makeDefault() -> AppContainer {
        let auth = AuthService()
        let client = NetworkClient(
            baseURL: EnvironmentConfig.apiBaseURL,
            session: .shared,
            tokenProvider: { nil },
            authService: auth
        )
        let feed = FeedService(client: client)
        let post = PostService(client: client)
        let community = CommunityService(client: client)
        let moderation = ModerationService(client: client)
        let haptics = HapticFeedbackService()
        return AppContainer(
            authService: auth,
            networkClient: client,
            feedService: feed,
            postService: post,
            communityService: community,
            moderationService: moderation,
            haptics: haptics
        )
    }
}
