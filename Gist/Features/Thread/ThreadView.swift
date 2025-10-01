import SwiftUI

public struct ThreadView: View {
    @StateObject private var viewModel = ThreadViewModel()
    public init() {}
    public var body: some View {
        List(viewModel.state.comments) { comment in
            CommentRowView(comment: comment)
        }
    }
}

#Preview("Thread") {
    ThreadView()
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
}
