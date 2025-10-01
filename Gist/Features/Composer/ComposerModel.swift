import Foundation
import GistCore

public struct ComposerUIState: Equatable {
    public var title: String = ""
    public var body: String = ""
    public var identity: IdentityMode = .public
    public var altText: String = ""
}
