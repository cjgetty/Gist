import SwiftUI

public struct CommunityView: View {
    @StateObject private var viewModel = CommunityViewModel()
    public init() {}
    public var body: some View {
        VStack(spacing: 16) {
            Text(viewModel.state.community.name)
                .font(.largeTitle)
                .bold()
                .accessibilityLabel("Community \(viewModel.state.community.name)")
            Button(viewModel.state.isMember ? "Leave" : "Join") {
                Task { await viewModel.toggleMembership() }
            }
            .buttonStyle(.borderedProminent)
            .accessibilityLabel(viewModel.state.isMember ? "Leave community" : "Join community")
            List(viewModel.state.community.rules, id: \.self) { rule in
                Text(rule)
                    .accessibilityLabel("Rule: \(rule)")
            }
        }
        .padding()
        .navigationTitle("Community")
    }
}

#Preview("Community") {
    NavigationStack { CommunityView() }
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
}
