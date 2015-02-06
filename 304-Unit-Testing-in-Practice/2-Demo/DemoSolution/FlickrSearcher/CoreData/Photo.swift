//
//  Photo.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 11/30/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import CoreData

public class Photo : NSManagedObject {
  
  //MARK: Managed Object Properties
  
  @NSManaged public var fullURLString: NSString
  @NSManaged public var thumbnailURLString: NSString
  @NSManaged public var photoID: NSString
  @NSManaged public var title: NSString
  @NSManaged public var owner: User
  
  //ATTENTION NON-AMERICANS: Be consistent about your spelling of "favorite" vs. "favourite"
  @NSManaged public var isFavorite: Bool
  
  //MARK: Helper method
  
  /**
  Grabs a photo from the given context with the given ID, or creates a new one.
  
  :param: context The managed object context to search
  :param: photoID The ID to search for
  
  :returns: The existing or new photo with the given ID
  */
  class func photoInContextOrNew(context: NSManagedObjectContext, photoID: String) -> Photo {
    let predicate = NSPredicate(format: "photoID == \(photoID)")
    let fetchRequest = flk_fetchRequestWithPredicate(predicate)
    
    var error: NSError?
    let results = context.executeFetchRequest(fetchRequest, error: &error)
    
    if let unwrappedResults = results {
      if let photo = unwrappedResults.first as? Photo {
        //Found existing
        return photo
      }
    }
    
    //Did not find existing, create new.
    let created = flk_newInContext(context) as Photo
    created.photoID = photoID
    return created
  }
}
