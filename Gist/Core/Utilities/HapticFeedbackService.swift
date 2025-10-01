import Foundation
import UIKit

public protocol HapticFeedbackServiceProtocol {
    func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle)
}

public final class HapticFeedbackService: HapticFeedbackServiceProtocol {
    public init() {}
    public func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        guard !UIAccessibility.isReduceMotionEnabled else { return }
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
