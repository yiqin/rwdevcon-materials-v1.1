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
  func find<T : NSManagedObject>(type:T.Type, orderedBy: [NSSortDescriptor]? = nil, predicate:NSPredicate? = nil) -> [T]?
  {
    let request = NSFetchRequest(entityName: entityNameFromType(type))
    request.predicate = predicate
    request.sortDescriptors = orderedBy
    
    var result : [T]?
    var error : NSError?
    let context = mainContext
    context.performBlockAndWait {
      result = context.executeFetchRequest(request, error: &error) as? [T]
    }
    if result == nil
    {
      logger.error("[find] \(error)")
    }
    return result
  }
  
  func findFirst<T : NSManagedObject>(type:T.Type, predicate:NSPredicate? = nil) -> T?
  {
    let request = NSFetchRequest(entityName: entityNameFromType(type))
    request.predicate = predicate
    request.fetchLimit = 1
    
    var error : NSError?
    let result = mainContext.executeFetchRequest(request, error: &error) as? [T]
    if result == nil
    {
      logger.error("[find] \(error)")
    }
    return result?.first
  }
  
  func exists<T : NSManagedObject>(type:T.Type, predicate:NSPredicate? = nil) -> Bool
  {
    let request = NSFetchRequest(entityName: entityNameFromType(type))
    request.predicate = predicate
    
    var error : NSError?
    let count = mainContext.countForFetchRequest(request, error: &error)
    if count == NSNotFound
    {
      logger.error("[exists] \(error)")
    }
    return count > 0
  }
  
  public func create<T : NSManagedObject>(type:T.Type) -> T?
  {
    return create(type, inContext: backgroundContext)
  }
  //
  //    func createInBackground<T : NSManagedObject>(type:T.Type) -> T?
  //    {
  //        return create(type, inContext: self.backgroundContext)
  //    }
  
  func create<T : NSManagedObject>(type:T.Type, inContext context:NSManagedObjectContext) -> T?
  {
    var object : T?
    //TODO: add after adding ConcurrencyDebug flag
    context.performBlockAndWait {
      let entityName = entityNameFromType(type)
      let entity = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: context) as NSManagedObject
      object = cast(entity)
    }
    return object
  }
  
  public func save()
  {
    saveUsing(Context: backgroundContext)
  }
  
  //TODO: Write save
  func saveUsing(Context context:NSManagedObjectContext)
  {
    let logger = self.logger
    //TODO: Start without performBlock add ConcurrencyDebug flag
    context.performBlock {
      var error : NSError?
      
      if context.hasChanges
      {
        let saved = context.save(&error)
        if !saved
        {
          logger.error("Error saving: \(error)")
        }
        else
        {
          if let parentContext = context.parentContext {
            self.saveUsing(Context: parentContext)
          }
          else {
            logger.debug("Saved context successfully")
          }
        }
      }
      else
      {
        logger.warn("No changes to save")
      }
    }
  }
}
