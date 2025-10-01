import GistCore
import SwiftUI

public struct CommentRowView: View {
    public let comment: Comment
    public init(comment: Comment) { self.comment = comment }
    public var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 28, height: 28)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 4) {
                Text(comment.bodyMD)
                    .font(.body)
                    .accessibilityLabel("Comment: \(comment.bodyMD)")
                HStack(spacing: 12) {
                    Label("\(comment.score)", systemImage: "arrow.up")
                        .labelStyle(.iconOnly)
                        .accessibilityLabel("Score \(comment.score)")
                    Text(comment.createdAt.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .accessibilityHidden(true)
                }
            }
        }
        .padding(.vertical, 6)
    }
}

#Preview("Comment Row") {
    CommentRowView(comment: MockData.sampleComments[0])
        .padding()
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
}
