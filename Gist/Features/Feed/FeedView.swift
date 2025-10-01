import GistCore
import SwiftUI

public struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    public init() {}
    public var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.posts) { post in
                    NavigationLink {
                        PostDetailView(post: post)
                    } label: {
                        PostCardView(post: post)
                    }
                    .accessibilityLabel("Open post: \(post.title)")
                }
            }
            .navigationTitle("Home")
            .overlay(alignment: .center) {
                if viewModel.posts.isEmpty { ProgressView().accessibilityLabel("Loading feed") }
            }
            .task { await viewModel.load() }
        }
    }
}

#Preview("Feed") {
    FeedView()
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
}
