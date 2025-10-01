import SwiftUI

public struct InboxView: View {
    @StateObject private var viewModel = InboxViewModel()
    public init() {}
    public var body: some View {
        NavigationStack {
            List(viewModel.state.items) { item in
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.text)
                        .accessibilityLabel("Notification: \(item.text)")
                    Text(item.createdAt.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .accessibilityHidden(true)
                }
            }
            .navigationTitle("Inbox")
        }
    }
}

#Preview("Inbox") {
    InboxView()
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
}
