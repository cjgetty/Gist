import Foundation
import Combine

@MainActor
public final class ProfileViewModel: ObservableObject {
    @Published public var state = ProfileUIState()
}
