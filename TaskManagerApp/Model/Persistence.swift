//
//  Persistence.swift
//  TaskManagerApp
//
//  Created by Can Kanbur on 1.06.2023.
//

import CoreData

struct PersistenceController {
    // MARK: - Persisten controller

    static let shared = PersistenceController()

    // MARK: - Persisten container

    let container: NSPersistentContainer

    // MARK: - INITILAZITION load persisten store

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TaskManagerApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    // MARK: - Preview

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = "Sample Task no\(i)"
            newItem.completion = false
            newItem.id = UUID()
            
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
