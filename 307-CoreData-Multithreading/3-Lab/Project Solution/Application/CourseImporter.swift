//
//  CourseDataImporter.swift
//  CourseCatalog
//
//  Created by Saul Mora on 12/7/14.
//  Copyright (c) 2014 Magical Panda. All rights reserved.
//

import UIKit
import Argo
import Runes
import Swell
import CoreData

public class CourseImporter: NSObject
{
  private let logger = Swell.getLogger("CourseImporter")
  public var results : [Course] = []
  internal dynamic var progress : Float = 0
  
  let stack : CoreDataStack
  
  public init(stack:CoreDataStack = CoreDataStack(storeName: "catalog.sqlite")) {
    self.stack = stack
  }
  
  func urlForResourceNamed(name:String, bundle:NSBundle) -> NSURL?
  {
    return bundle.URLForResource(name.stringByDeletingPathExtension, withExtension: name.pathExtension)
  }
  
  func inputStreamFromURL(resourceURL:NSURL) -> NSInputStream?
  {
    return NSInputStream(URL: resourceURL)
  }
  
  func jsonObjectFromInputStream(inputStream:NSInputStream) -> JSONValue?
  {
    inputStream.open()
    if let jsonObject: AnyObject = NSJSONSerialization.JSONObjectWithStream(inputStream, options: NSJSONReadingOptions.allZeros, error: nil) {
      return JSONValue.parse(jsonObject)
    }
    return .None
  }
  
  func importJSONDataInResourceNamed(name:String, inBundle bundle:NSBundle = NSBundle.mainBundle())
  {
    if let url = urlForResourceNamed(name, bundle:bundle)
    {
      let courses = url
        >>- inputStreamFromURL
        >>- jsonObjectFromInputStream
        >>- importData
      
      results = courses ?? []
    }
  }
  
  public func importData(From dataObject:JSONValue) -> [Course]
  {
    let results = dataObject
      >>- _Course.decodeObjects
      >>- mapSome
      >>- adaptCourses
    
    logger.debug("Imported \(results?.count) courses")
    return results ?? []
  }
  
  private var adaptCoursesTotal : Float = 0
  private var adaptedCoursesCount = 0
  //TODO: Add steps for watching import progress
  func adaptCourses(courses:[_Course]) -> [Course]
  {
    let adapter = CourseAdapter(stack: stack)
    adaptCoursesTotal = Float(courses.count)
    logger.debug("Start Adapting \(adaptCoursesTotal) _Course objects")
    
    let notificationCenter = NSNotificationCenter.defaultCenter()
    let context = stack.backgroundContext
    var results : [Course] = []
    watchNotificationsNamed(NSManagedObjectContextObjectsDidChangeNotification, fromObject: context, usingSelector: Selector("contextDidChange:"))
      {
        results = adapter.adapt(courses)
    }
    return results
  }
  
  func watchNotificationsNamed(notificationName:String, fromObject object:AnyObject? = nil, usingSelector selector:Selector, inScope scope:() -> ())
  {
    let notificationCenter = NSNotificationCenter.defaultCenter()
    let watcher = self
    notificationCenter.addObserver(watcher, selector: selector, name: notificationName, object: object)
    scope()
    notificationCenter.removeObserver(watcher, name: notificationName, object: object)
  }
  
  func contextDidChange(notification:NSNotification)
  {
    let insertedObjects = notification.insertedObjects
    adaptedCoursesCount += insertedObjects.count
    progress = Float(adaptedCoursesCount) / adaptCoursesTotal
  }
}

extension NSNotification {
  var insertedObjects : NSSet {
    return userInfo?[NSInsertedObjectsKey] as? NSSet ?? NSSet()
  }
}
