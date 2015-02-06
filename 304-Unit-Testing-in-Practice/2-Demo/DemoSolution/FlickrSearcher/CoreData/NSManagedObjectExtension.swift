//
//  NSManagedObjectExtension.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 11/30/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import CoreData

public extension NSManagedObject {
  
  /**
  Creates a new instance of a managed object in the given context.
  
  :param: context The NSManagedObject in which to add the object
  :returns: The instantiated object, inserted into the MOC, or nil if any of the failable initializers...fails.
  */
  class func flk_newInContext(context: NSManagedObjectContext) -> NSManagedObject? {
    let entityDescription = NSEntityDescription.entityForName(flk_className(), inManagedObjectContext: context)
    if let unwrappedDescription = entityDescription {
      let object = NSManagedObject(entity: unwrappedDescription, insertIntoManagedObjectContext: context)
      return object
    }
    
    return nil
  }
}