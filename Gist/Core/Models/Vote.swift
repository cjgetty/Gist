import Foundation

public struct Vote: Codable, Equatable {
    public enum TargetType: String, Codable { case post, comment }
    public var userId: UUID
    public var targetType: TargetType
    public var targetId: UUID
    public var value: Int // -1, 0, +1
}
