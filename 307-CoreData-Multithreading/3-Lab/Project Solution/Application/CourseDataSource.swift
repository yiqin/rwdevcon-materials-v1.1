//
//  CourseDataSource.swift
//  CourseCatalog
//
//  Created by Saul Mora on 1/3/15.
//  Copyright (c) 2015 Magical Panda. All rights reserved.
//

import CoreData
import Argo

class CourseDataSource: NSObject {
  private var course : Course?
  
  init(course:Course) {
    self.course = course
    
    super.init()
  }
}
