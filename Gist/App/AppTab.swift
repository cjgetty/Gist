import Foundation

public enum AppTab: CaseIterable {
    case home, discover, create, inbox, profile

    public var title: String {
        switch self {
        case .home: return "Home"
        case .discover: return "Discover"
        case .create: return "Create"
        case .inbox: return "Inbox"
        case .profile: return "Profile"
        }
    }

    public var systemImage: String {
        switch self {
        case .home: return "house"
        case .discover: return "safari"
        case .create: return "plus.square.on.square"
        case .inbox: return "tray"
        case .profile: return "person.crop.circle"
        }
    }
}
