//
//  BrowseRecipesApp.swift
//  BrowseRecipes
//
//  Created by Karthik Jami on 7/2/24.
//

import SwiftUI
import SwiftData

@main
struct BrowseRecipesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
                    SplashScreenView()
                        .environment(\.colorScheme, .dark)
                }
                #if os(macOS)
                .windowStyle(HiddenTitleBarWindowStyle())
                #endif
                .modelContainer(sharedModelContainer)
    }
}
