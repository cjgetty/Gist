import Foundation
import Combine

@MainActor
public final class ThreadViewModel: ObservableObject {
    @Published public private(set) var state = ThreadUIState()
}
