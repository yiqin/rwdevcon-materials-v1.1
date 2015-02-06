//
//  CourseDataSource.swift
//  CourseCatalog
//
//  Created by Saul Mora on 1/3/15.
//  Copyright (c) 2015 Magical Panda. All rights reserved.
//

import CoreData
import Argo
import Runes

class CourseDataSource: NSObject {
  private let stack : CoreDataStack = CoreDataStack(storeName: "catalog.sqlite")
  private var course : Course?
  
  init(course:Course) {
    
    var error : NSError?
    self.course = course
    
    super.init()
  }
  
  func updateCourseDetails(completion:(Course?) -> ()) {
    let courseID = course?.remoteID.integerValue ?? 0
    let context = stack.mainContext
    requestCourse(courseID) { result in
      context.performBlock {
        completion(result.value!)
      }
    }
  }
  
  func parseJSON(json:JSONValue) -> Course?
  {
    return json
      >>- _Course.decodeObjects
      >>- mapSome
      >>- { $0.first }
      >>- CourseAdapter(stack: stack).adapt
  }
  
  func requestCourse(id:Int, completion: (Result<Course>) -> ()) {
    let baseURL = NSURL(string: "https://api.coursera.org/api/catalog.v1/courses")!
    let queryString = "id=\(id)&fields=largeIcon,smallIcon,shortDescription,aboutTheCourse"
    
    let courseResource = jsonResource("courses", .GET, .JSONNull, parseJSON)
    let modifyRequest = { (urlRequest : NSMutableURLRequest) in
      urlRequest.URL = NSURL(string:baseURL.absoluteString! + "?" + queryString)
    }
    apiRequest(modifyRequest, baseURL, courseResource, defaultFailureHandler) { course in
      completion(Result(course))
    }
  }
}
