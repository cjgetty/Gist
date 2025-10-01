import Foundation

public enum EnvironmentConfig {
    public static var apiBaseURL: URL { URL(string: "https://api.example.com/")! }
    public static var featureFlags: [String: Bool] = [
        "enableNewOnboarding": false,
        "debugLogging": true
    ]
}
