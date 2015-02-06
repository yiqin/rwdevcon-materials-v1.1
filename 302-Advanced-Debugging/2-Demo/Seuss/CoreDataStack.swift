//
//  CoreDataStack.swift
//  Seuss
//
//  Created by Richard Turton on 17/11/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    lazy var model : NSManagedObjectModel = {
        let url = NSBundle.mainBundle().URLForResource("Seuss", withExtension: "momd")
        return NSManagedObjectModel(contentsOfURL: url!)!
    }()
    
    lazy var coordinator : NSPersistentStoreCoordinator = {
        let psc = NSPersistentStoreCoordinator(managedObjectModel: self.model)
        psc.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil, error: nil)
        return psc
    }()
    
    lazy var context : NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.coordinator
        return context
    }()
}

extension CoreDataStack {
    func booksResultController () -> NSFetchedResultsController {
        let request = NSFetchRequest(entityName: "Book")
        request.sortDescriptors = [NSSortDescriptor(key: "year", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
}
