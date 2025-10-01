import Foundation
import Combine
import GistCore

@MainActor
public final class DiscoverViewModel: ObservableObject {
    @Published public var state = DiscoverUIState()
    @Published public private(set) var trending: [Community] = MockData.sampleCommunities
}
