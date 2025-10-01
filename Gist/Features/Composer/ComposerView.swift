import GistCore
import SwiftUI

public struct ComposerView: View {
    @StateObject private var viewModel = ComposerViewModel()
    public init() {}
    public var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $viewModel.state.title)
                    .accessibilityLabel("Post title")
                TextEditor(text: $viewModel.state.body)
                    .frame(minHeight: 140)
                    .accessibilityLabel("Post body")
                Picker("Identity", selection: $viewModel.state.identity) {
                    ForEach(IdentityMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue.capitalized).tag(mode)
                    }
                }.accessibilityLabel("Identity mode")
                TextField("ALT text for images", text: $viewModel.state.altText)
                    .accessibilityLabel("ALT text")
            }
            .navigationTitle("Create")
            .toolbar { Button("Post") { Task { await viewModel.submit() } }.accessibilityLabel("Post button") }
        }
    }
}

#Preview("Composer") {
    ComposerView()
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
}
