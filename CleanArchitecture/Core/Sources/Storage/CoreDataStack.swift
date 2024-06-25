//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/19/24.
//

import Foundation
import CoreData

public final class CoreDataStack: ObservableObject {
    
    let managedObjectModel: NSManagedObjectModel
    let containerName: String
    let inMemory: Bool
    
    public init(managedObjectModel: NSManagedObjectModel, _ containerName: String, inMemory: Bool = false) {
        self.managedObjectModel = managedObjectModel
        self.containerName = containerName
        self.inMemory = inMemory
    }
    
    public var mainContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // Create a persistent container as a lazy variable to defer instantiation until its first use.
    lazy var persistentContainer: NSPersistentContainer = {
        
        // Pass the data model filename to the container’s initializer.
        let container = NSPersistentContainer(name: containerName, managedObjectModel: managedObjectModel)
                
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        // Load any persistent stores, which creates a store if none exists.
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
}

public extension CoreDataStack {
    
    func save() async throws  {
        guard persistentContainer.viewContext.hasChanges else { return }
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            throw error
        }
    }
}

// reference https://github.com/fatbobman/CoreDataInPreview/blob/main/PreviewStudy/Persistence.swift

// refernce https://www.fline.dev/swiftpm-coredata-failing-swiftui-previews-here-are-5-tips-to-fix/
