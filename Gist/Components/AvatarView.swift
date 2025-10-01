import SwiftUI

public struct AvatarView: View {
    public let size: CGFloat
    public init(size: CGFloat = 32) { self.size = size }
    public var body: some View {
        Circle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: size, height: size)
            .overlay(
                Image(systemName: "person.fill")
                    .font(.system(size: size * 0.5))
                    .foregroundStyle(.secondary)
            )
            .accessibilityLabel("Avatar")
    }
}

#Preview("Avatar") {
    HStack { AvatarView(); AvatarView(size: 48) }
        .padding()
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
}
