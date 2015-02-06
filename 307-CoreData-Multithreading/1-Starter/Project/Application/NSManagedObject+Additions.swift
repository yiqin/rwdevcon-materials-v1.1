//
//  NSManagedObject+Additions.swift
//  CourseCatalog
//
//  Created by Saul Mora on 12/23/14.
//  Copyright (c) 2014 Magical Panda. All rights reserved.
//

import CoreData

extension NSManagedObject
{
  class func entityName() -> String
  {
    return NSStringFromClass(self.dynamicType)
  }
}