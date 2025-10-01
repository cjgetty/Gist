import SwiftUI

public struct ModerationView: View {
    @StateObject private var viewModel = ModerationViewModel()
    public init() {}
    public var body: some View {
        NavigationStack {
            List(viewModel.state.queue, id: \.self) { item in
                Text(item).accessibilityLabel("Report: \(item)")
            }
            .navigationTitle("Moderation")
        }
    }
}

#Preview("Moderation") {
    ModerationView()
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
}
