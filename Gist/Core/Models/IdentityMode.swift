import Foundation

public enum IdentityMode: String, Codable, CaseIterable {
    case `public`
    case pseudonymous
    case anonymous
}
