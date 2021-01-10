//
//  PhoenixApp.swift
//  Shared
//
//  Created by Pez on 09/01/2021.
//

import SwiftUI

@main
struct PhoenixApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
