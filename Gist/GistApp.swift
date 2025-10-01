//
//  GistApp.swift
//  Gist
//
//  Created by Cameron Getty on 9/30/25.
//

import GistCore
import SwiftUI

@main
struct GistApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                FeedView()
                    .tabItem { Label("Home", systemImage: "house") }
                    .accessibilityLabel("Home Tab")

                DiscoverView()
                    .tabItem { Label("Discover", systemImage: "safari") }
                    .accessibilityLabel("Discover Tab")

                ComposerView()
                    .tabItem { Label("Create", systemImage: "plus.square.on.square") }
                    .accessibilityLabel("Create Tab")

                InboxView()
                    .tabItem { Label("Inbox", systemImage: "tray") }
                    .accessibilityLabel("Inbox Tab")

                ProfileView()
                    .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                    .accessibilityLabel("Profile Tab")
            }
        }
    }
}
