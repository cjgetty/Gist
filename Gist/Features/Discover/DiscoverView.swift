import SwiftUI

public struct DiscoverView: View {
    @StateObject private var viewModel = DiscoverViewModel()
    public init() {}
    public var body: some View {
        NavigationStack {
            List {
                Section("Trending Communities") {
                    ForEach(viewModel.trending) { community in
                        NavigationLink {
                            CommunityView()
                        } label: {
                            HStack {
                                Text(community.name)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.tertiary)
                                    .accessibilityHidden(true)
                            }
                            .accessibilityLabel("Community \(community.name)")
                        }
                    }
                }
            }
            .navigationTitle("Discover")
            .searchable(text: $viewModel.state.query)
        }
    }
}

#Preview("Discover") {
    DiscoverView()
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
}
