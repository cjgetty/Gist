import GistCore
import SwiftUI

public struct PostCardView: View {
    public let post: Post
    public init(post: Post) { self.post = post }
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(post.title)
                .font(.headline)
                .accessibilityLabel("Post title: \(post.title)")
            Text(post.bodyMD)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(3)
                .accessibilityLabel("Post body preview")
            HStack(spacing: 16) {
                Button { /* upvote stub */ } label: { Label("Upvote", systemImage: "arrow.up") }
                    .accessibilityLabel("Upvote")
                    .accessibilityIdentifier("Upvote")
                Button { /* reply stub */ } label: { Label("Reply", systemImage: "arrowshape.turn.up.left") }
                    .accessibilityLabel("Reply")
                    .accessibilityIdentifier("Reply")
                Button { /* save stub */ } label: { Label("Save", systemImage: "bookmark") }
                    .accessibilityLabel("Save")
                    .accessibilityIdentifier("Save")
                Button { /* share stub */ } label: { Label("Share", systemImage: "square.and.arrow.up") }
                    .accessibilityLabel("Share")
                    .accessibilityIdentifier("Share")
            }
            .labelStyle(.iconOnly)
            .buttonStyle(.borderless)
        }
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview("Post Card") {
    PostCardView(post: MockData.samplePosts[0])
        .padding()
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
}
