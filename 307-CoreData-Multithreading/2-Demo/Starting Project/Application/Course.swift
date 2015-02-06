//
//  Course.swift
//  CourseCatalog
//
//  Created by Saul Mora on 12/7/14.
//  Copyright (c) 2014 Magical Panda. All rights reserved.
//

import Foundation
import CoreData

protocol TableViewCellDisplayable {
  var displayDescription : String { get }
}

public class Course: NSManagedObject, TableViewCellDisplayable {
  
  @NSManaged public var remoteID: NSNumber!
  @NSManaged public var name: String!
  @NSManaged public var shortName: String!
  @NSManaged public var smallIcon: AnyObject!
  @NSManaged public var largeIcon: AnyObject!
  @NSManaged public var instructorName: String!
  @NSManaged public var summary: String!
  @NSManaged public var syllabus: String!
  
  public var displayDescription : String {
    return name
  }
  
  override class func entityName() -> String {
    return "Course"
  }
}
