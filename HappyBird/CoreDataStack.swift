//
//  CoreDataStack.swift
//  HappyBird
//
//  Created by Thao Doan on 7/11/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let share = CoreDataStack()
    
// MARK: - Core Data stack

lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "HappyBird")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

// MARK: - Core Data Saving support

func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

}

