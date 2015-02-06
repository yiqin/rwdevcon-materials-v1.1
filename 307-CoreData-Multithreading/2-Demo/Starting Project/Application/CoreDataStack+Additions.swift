//
//  CoreDataStack+Additions.swift
//  CourseCatalog
//
//  Created by Saul Mora on 12/29/14.
//  Copyright (c) 2014 Magical Panda. All rights reserved.
//

import Foundation
import CoreData
import Swell

private func entityNameFromType<T : NSManagedObject>(type:T.Type) -> String
{
  if let entityName = type.entityName().componentsSeparatedByString(".").last {
    return entityName
  }
  return NSStringFromClass(type)
}

extension CoreDataStack
{
  func find<T : NSManagedObject>(type:T.Type, orderedBy: [NSSortDescriptor]? = nil, predicate:NSPredicate? = nil) -> [T]? {
    return find(type, orderedBy: orderedBy, predicate: predicate, inContext: mainContext)
  }
  
  func find<T : NSManagedObject>(type:T.Type, orderedBy: [NSSortDescriptor]? = nil, predicate:NSPredicate? = nil, inContext context:NSManagedObjectContext) -> [T]? {
    let request = NSFetchRequest(entityName: entityNameFromType(type))
    request.predicate = predicate
    request.sortDescriptors = orderedBy
    
    var error : NSError?
    let result = context.executeFetchRequest(request, error: &error) as? [T]
    if result == nil {
      logger.error("[find] \(error)")
    }
    return result
  }
  
  public func create<T : NSManagedObject>(type:T.Type) -> T? {
    return create(type, inContext: backgroundContext)
  }
  
  func create<T : NSManagedObject>(type:T.Type, inContext context:NSManagedObjectContext) -> T? {
    let entityName = entityNameFromType(type)
    let entity = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: context) as NSManagedObject
    return cast(entity)
  }
  
  public func save() {
    saveUsing(Context: backgroundContext)
  }
  
  func saveUsing(Context context:NSManagedObjectContext) {
    if context.hasChanges {
      var error :NSError?
      let success = context.save(&error)
      if !success {
        logger.error("Could not save \(error)")
      }
    }
  }
}
