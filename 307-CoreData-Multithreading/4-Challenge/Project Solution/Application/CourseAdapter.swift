//
//  CourseAdapter.swift
//  CourseCatalog
//
//  Created by Saul Mora on 1/4/15.
//  Copyright (c) 2015 Magical Panda. All rights reserved.
//

import Foundation
import Swell

class CourseAdapter
{
  private let logger = Swell.getLogger("CourseAdapter")
  let stack : CoreDataStack
  init(stack:CoreDataStack)
  {
    self.stack = stack
    logger.debug("Creating Couse object adapter")
  }
  
  func adapt(courses:[_Course]) -> [Course]
  {
    let existingCourseFilter = NSPredicate(format: "remoteID in %@", courses.map { $0.remoteID })
    let existingCourses = stack.find(Course.self, predicate: existingCourseFilter)
    
    let updatedExistingCourses = adaptExistingCourses(existingCourses, from: courses)
    let newAdaptedCourses = adaptNewCourses(updatedExistingCourses, from: courses)
    
    return newAdaptedCourses + updatedExistingCourses
  }
  
  func adapt(course:_Course) -> Course
  {
    let existingCourseFilter = NSPredicate(format: "remoteID = %d", course.remoteID)
    let existingCourse = stack.find(Course.self, predicate: existingCourseFilter)?.first
    
    return adapt(course: existingCourse, from:course)
  }
  
  private func adaptNewCourses(existingCourses:[Course]?, from courses:[_Course]) -> [Course]
  {
    if let existingCourses = existingCourses
    {
      let existingCourseIDs = existingCourses.map { $0.remoteID.integerValue }
      let newRawCourses = courses.filter { find(existingCourseIDs, $0.remoteID) == nil }
      
      logger.debug("Adapting \(newRawCourses.count) new courses")
      return newRawCourses.map { self.adapt(from: $0) }
    }
    return []
  }
  
  private func adaptExistingCourses(existingCourses:[Course]?, from rawCourses:[_Course]) -> [Course]
  {
    if let existingCourses = existingCourses
    {
      let existingCourseIDs = existingCourses.map { $0.remoteID.integerValue }
      let existingRawCourses = rawCourses.filter { find(existingCourseIDs, $0.remoteID) != nil }
      
      logger.debug("Adapting \(existingCourses.count) existing courses")
      return existingCourses.map { course in
        let filtered = filter(rawCourses) { $0.remoteID == course.remoteID }
        return self.adapt(course: course, from:filtered.first!)
      }
    }
    return []
  }
  
  private func adapt(course:Course? = nil, from rawCourse:_Course) -> Course
  {
    var adapted : Course = course ?? stack.create(Course.self)!
    
    let context = stack.backgroundContext
    context.performBlockAndWait {
      adapted.remoteID = rawCourse.remoteID
      adapted.name = rawCourse.name
      adapted.shortName = rawCourse.shortName
      //TODO: discuss difference between process pending change and did save
      context.processPendingChanges()
    }
    
    return adapted
  }
}
