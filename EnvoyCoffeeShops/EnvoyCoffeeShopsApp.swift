//
//  EnvoyCoffeeShopsApp.swift
//  EnvoyCoffeeShops
//
//  Created by Akshay Yadav on 2/23/25.
//

import SwiftUI
import SwiftData

@main
struct EnvoyCoffeeShopsApp: App {
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
            CoffeeShopsViewer()
        }
        .modelContainer(sharedModelContainer)
    }
}
