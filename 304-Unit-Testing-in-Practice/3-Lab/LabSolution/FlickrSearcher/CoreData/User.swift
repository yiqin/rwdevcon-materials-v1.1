//
//  User.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 11/30/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import CoreData

public class User : NSManagedObject {
  
  //MARK: Managed Object Properties
  
  @NSManaged public var userID: NSString
  public var name: NSString?
  public var iconURLString: NSString?
  
  //MARK: Helper method
  
  /**
  Grabs a user from the given context with the given ID, or creates a new one.
  
  :param: context The managed object context to search
  :param: userID The ID to search for
  
  :returns: The existing or new user with the given ID
  */
  
  class func userInContextOrNew(context: NSManagedObjectContext, userID: String) -> User {
    let predicate = NSPredicate(format: "userID ==[c] '\(userID)'")
    let fetchRequest = flk_fetchRequestWithPredicate(predicate)
    
    var error: NSError?
    let results = context.executeFetchRequest(fetchRequest, error: &error)
    
    if let unwrappedResults = results {
      if let user = unwrappedResults.first as? User {
        //User found!
        return user
      }
    }
    
    //None found, create new
    let created = flk_newInContext(context) as User
    created.userID = userID
    return created
  }
}
