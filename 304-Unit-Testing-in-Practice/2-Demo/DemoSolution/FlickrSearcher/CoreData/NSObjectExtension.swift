//
//  NSObjectExtension.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 12/1/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import UIKit
import CoreData

extension NSObject {
  
  /**
  A convenience method to reduce stringly-typed code by allowing developers to use the name of a class.
  
  :returns: The class name of the current class, stripped of the project name
  */
  public class func flk_className() -> String {
    let classString = NSStringFromClass(self)
    
    //This grabs a string that is [project name].[class name]
    
    let pieces = classString.componentsSeparatedByString(".")
    
    if pieces.count == 2 {
      return pieces[1]
    } else {
      //Return the full string.
      return classString
    }
  }
  
  /**
  Creates an NSFetchRequest for the current class with the given filtering predicate
  
  :param: predicate The predicate to filter on.
  
  :returns: The instantiated fetch request.
  */
  public class func flk_fetchRequestWithPredicate(predicate: NSPredicate?) -> NSFetchRequest {
    let fetchRequest = NSFetchRequest(entityName:flk_className())
    fetchRequest.predicate = predicate
    return fetchRequest
  }
}
