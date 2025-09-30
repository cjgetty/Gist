//
//  GistApp.swift
//  Gist
//
//  Created by Cameron Getty on 9/30/25.
//

import SwiftUI
import CoreData

@main
struct GistApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
