import SwiftUI

public struct VoteControlView: View {
    public var score: Int
    public var onUpvote: () -> Void
    public var onDownvote: () -> Void
    public init(score: Int, onUpvote: @escaping () -> Void, onDownvote: @escaping () -> Void) {
        self.score = score
        self.onUpvote = onUpvote
        self.onDownvote = onDownvote
    }
    public var body: some View {
        HStack(spacing: 8) {
            Button(action: onUpvote) { Image(systemName: "arrow.up") }
                .accessibilityLabel("Upvote")
            Text("\(score)")
                .monospacedDigit()
                .accessibilityLabel("Score \(score)")
            Button(action: onDownvote) { Image(systemName: "arrow.down") }
                .accessibilityLabel("Downvote")
        }
        .buttonStyle(.borderless)
    }
}

#Preview("Vote Control") {
    VoteControlView(score: 12, onUpvote: {}, onDownvote: {})
        .padding()
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
}
