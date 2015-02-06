//
//  CoreDataStack.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 11/30/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import CoreData

private let _singletonInstance = CoreDataStack()

//These two are public for testing.
public let ManagedObjectModelName = "FlickrSearcher"
public let ManagedObjectModelExtension = "momd"

/**
Class for managing access to Core Data.
*/
public class CoreDataStack {
  
  //Public variables
  public var isTesting = false
  
  //Singleton instance.
  public class func sharedInstance() -> CoreDataStack {
    return _singletonInstance
  }
  
  required public init() {
    //Well, this is silly.
  }
  
  //MARK - Old skool lazy getters
  
  /* 
  Backing variables - these can't really use the @lazy annotation
  because we want them to be able to be reset, and the @lazy annotation
  will only fire once.
  */
  var _managedObjectContext: NSManagedObjectContext?
  var _managedObjectModel: NSManagedObjectModel?
  var _persistentStoreCoordinator: NSPersistentStoreCoordinator?
  
  func model() -> NSManagedObjectModel {
    if _managedObjectModel == nil {
      let url = NSBundle.mainBundle().URLForResource(ManagedObjectModelName, withExtension: ManagedObjectModelExtension)
      _managedObjectModel = NSManagedObjectModel(contentsOfURL: url!)!
    }
    
    return _managedObjectModel!
  }
  
  func coordinator() -> NSPersistentStoreCoordinator {
    if _persistentStoreCoordinator == nil {
      _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.model())
      var storeType = NSSQLiteStoreType
      var url : NSURL? = self.databaseFileURL()
      if (self.isTesting) {
        //If we are testing, add the in-memory store type and do not use any URL.
        storeType = NSInMemoryStoreType
        url = nil
      }
            
      _persistentStoreCoordinator!.addPersistentStoreWithType(storeType,
        configuration: nil,
        URL: url,
        //Set these two options in order to have automatic migration work for Core Data:
        options: [
          NSMigratePersistentStoresAutomaticallyOption: true,
          NSInferMappingModelAutomaticallyOption: true,
        ],
        error: nil)
    }
    
    return _persistentStoreCoordinator!
  }
  
  public func mainContext() -> NSManagedObjectContext {
    if _managedObjectContext == nil {
      _managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
      _managedObjectContext!.persistentStoreCoordinator = self.coordinator()
    }
    
    return _managedObjectContext!
  }
  
  //MARK - Convenience
  
  /**
  Saves the main managed object context.
  */
  public func saveMainContext() {
    var error : NSError?
    mainContext().save(&error)
    
    if let error = error {
      assert(error != nil, "ERROR SAVING CONTEXT: \(error)")
    }
  }
  
  /**
  :returns: The full file url for the database
  */
  func databaseFileURL() -> NSURL {
    let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last! as NSURL
    
    let file = documentsDirectory.URLByAppendingPathComponent("FlickrSearcher.sqlite")
    return file
  }
  
  /**
  Resets all the backing variables for the stack and deletes any SQLite stores.
  */
  public func resetDatabase() {
    _managedObjectContext = nil
    _managedObjectModel = nil
    _persistentStoreCoordinator = nil
    
    let storePath = databaseFileURL().path!
    if NSFileManager.defaultManager().fileExistsAtPath(storePath) {
      var error: NSError?
      NSFileManager.defaultManager().removeItemAtPath(storePath, error: &error)
      if let error = error {
        NSLog("Error deleting file: \(error)")
      }
    } //else there was nothing to delete.
  }
}