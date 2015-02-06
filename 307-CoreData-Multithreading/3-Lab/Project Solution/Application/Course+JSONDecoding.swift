//
//  Course+JSONDecoding.swift
//  CourseCatalog
//
//  Created by Saul Mora on 12/22/14.
//  Copyright (c) 2014 Magical Panda. All rights reserved.
//

import Foundation
import Argo
import Runes
import Swell
import CoreData

struct _Course
{
  let remoteID:Int
  let name:String
  let shortName:String
  let smallIconURLString:String?
  let largeIconURLString:String?
  let aboutCourse:String?
  let courseDescription:String?
  
  static func create(remoteID:Int)
    (name:String)
    (shortName:String)
    (largeIcon:String?)
    (smallIcon:String?)
    (courseDescription:String?)
    (aboutTheCourse:String?)
    -> _Course
  {
    return _Course(remoteID: remoteID, name: name, shortName:shortName, smallIconURLString:smallIcon, largeIconURLString:largeIcon, aboutCourse:aboutTheCourse, courseDescription:courseDescription)
  }
  
}

extension _Course : JSONDecodable
{
  static func decodeObjects(json: JSONValue) -> [_Course?]?
  {
    let logger = Swell.getLogger("_Course:JSONDecodable")
    let elements : [JSONValue]? = json["elements"]?.value()
    
    let elementCount = (elements != nil) ? elements!.count : 0
    logger.debug("Decoding \(elementCount) elements")
    
    let results : [_Course?]? = elements?.map { elementInfo in
      return elementInfo >>- _Course.decode
    }
    logger.debug("Decoded \(results?.count) elements")
    return results
  }
  
  static func decode(json: JSONValue) -> _Course?
  {
    return json >>-
      {   data in
        _Course.create
          <^> data <| "id"
          <*> data <| "name"
          <*> data <| "shortName"
          <*> data <|? "largeIcon"
          <*> data <|? "smallIcon"
          <*> data <|? "shortDescription"
          <*> data <|? "aboutTheCourse"
    }
  }
}
