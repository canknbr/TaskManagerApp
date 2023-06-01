//
//  TaskManagerAppApp.swift
//  TaskManagerApp
//
//  Created by Can Kanbur on 1.06.2023.
//

import SwiftUI

@main
struct TaskManagerAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
