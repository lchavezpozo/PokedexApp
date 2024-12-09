//
//  CoreDataManager.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 9/12/24.
//

import CoreData

@MainActor
class CoreDataStack {
    static let shared = CoreDataStack()

    // MARK: - Persistent Container
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokedexModel")  // Nombre de tu modelo
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Save context
    func saveContext() async throws {
        guard context.hasChanges else { return }
        do {
            try await context.perform { [weak self] in
                try  self?.context.save()
            }
            
        } catch {
            throw error
        }
    }
    
    // MARK: - Fetch operation
    func fetch<T: NSManagedObject>(_ entity: T.Type, predicate: NSPredicate? = nil) async throws -> [T] {
        let request = T.fetchRequest()
        request.predicate = predicate

        guard let typedRequest = request as? NSFetchRequest<T> else {
            fatalError("Invalid fetch request type")
        }

        do {
            return try context.fetch(typedRequest)
        } catch {
            throw error
        }
    }
    
    // MARK: - Insert operation
    func insert<T: NSManagedObject>(_ entity: T.Type) -> T {
        return T(context: context)
    }
    
    // MARK: - Delete operation
    func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
    
    // MARK: - Clear All Entities
    func clearAllData() async throws {
        let entityNames = persistentContainer.managedObjectModel.entities.map { $0.name! }
        for entityName in entityNames {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try context.execute(deleteRequest)
            } catch {
                throw error
            }
        }
    }
}
