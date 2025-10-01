import Foundation

public enum MockData {
    public static let sampleUser = User(id: UUID(), email: "user@example.com", createdAt: Date())

    public static let sampleCommunities: [Community] = [
        Community(id: UUID(), name: "iOS", slug: "ios", rules: ["Be kind", "No piracy"], isNSFW: false),
        Community(id: UUID(), name: "Design", slug: "design", rules: ["Critique respectfully"], isNSFW: false)
    ]

    public static let samplePosts: [Post] = [
        Post(id: UUID(), communityId: sampleCommunities[0].id, authorUserId: sampleUser.id, identityMode: .public, title: "Welcome to Gist", bodyMD: "First post on Gist!", mediaURLs: [], score: 42, createdAt: Date()),
        Post(id: UUID(), communityId: sampleCommunities[1].id, authorUserId: nil, identityMode: .anonymous, title: "Design tips", bodyMD: "Use lots of white space.", mediaURLs: [], score: 10, createdAt: Date())
    ]

    public static let sampleComments: [Comment] = [
        Comment(id: UUID(), postId: samplePosts[0].id, parentId: nil, authorUserId: sampleUser.id, identityMode: .public, bodyMD: "Nice!", score: 3, createdAt: Date())
    ]

    public static let sampleNotifications: [String] = [
        "Alice replied to your post",
        "Bob mentioned you",
        "Community iOS trending"
    ]
}
