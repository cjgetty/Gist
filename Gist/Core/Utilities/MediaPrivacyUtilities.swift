import Foundation

public enum MediaPrivacyUtilities {
    /// Placeholder hook to strip EXIF metadata before upload. Backend will also enforce stripping.
    public static func stripEXIFIfNeeded(from data: Data) -> Data { data }
}
