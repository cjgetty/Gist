import Foundation

public struct Community: Identifiable, Codable, Equatable {
    public let id: UUID
    public var name: String
    public var slug: String
    public var rules: [String]
    public var isNSFW: Bool
}
