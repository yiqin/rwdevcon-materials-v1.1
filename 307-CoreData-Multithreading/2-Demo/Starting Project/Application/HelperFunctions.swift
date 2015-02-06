//
//  Functions.swift
//  CourseCatalog
//
//  Created by Saul Mora on 12/23/14.
//  Copyright (c) 2014 Magical Panda. All rights reserved.
//

import UIKit


internal func mapSome<T>(items:[T?]) -> [T] {
  return items.filter { $0 != nil }.map { $0! }
}

internal func topController(navController:UINavigationController) -> UIViewController {
  return navController.topViewController
}

internal func cast<T>(object:AnyObject) -> T? {
  return  object as? T
}

internal func cast<T, U>(object:T?) -> U?
{
  if let object = object {
    return object as? U
  }
  return .None
}
