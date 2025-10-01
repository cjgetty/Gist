import SwiftUI

public struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    public init() {}
    public var body: some View {
        NavigationStack {
            Form {
                TextField("Display Name", text: $viewModel.state.profile.displayName)
                    .accessibilityLabel("Display name")
                TextField("Bio", text: $viewModel.state.profile.bio)
                    .accessibilityLabel("Bio")
                Picker("Privacy", selection: $viewModel.state.profile.privacyLevel) {
                    Text("Public").tag("Public")
                    Text("Private").tag("Private")
                }
                .accessibilityLabel("Privacy level")
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview("Profile") {
    NavigationStack { ProfileView() }
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
}
