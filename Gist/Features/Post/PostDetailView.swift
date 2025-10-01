import SwiftUI
import GistCore

public struct PostDetailView: View {
    public let post: Post
    public init(post: Post) { self.post = post }
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(post.title)
                    .font(.title)
                    .bold()
                    .accessibilityIdentifier("PostDetailTitle")
                Text(post.bodyMD)
                    .font(.body)
                    .accessibilityIdentifier("PostDetailBody")
            }
            .padding()
        }
        .navigationTitle("Post")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("Post Detail") {
    NavigationStack { PostDetailView(post: MockData.samplePosts[0]) }
}
