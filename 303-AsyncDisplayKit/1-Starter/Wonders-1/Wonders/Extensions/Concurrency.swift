//
//  Concurrency.swift
//  Wonders
//
//  Created by Rene Cacheaux on 1/28/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

extension dispatch_queue_t {
  class var mainQueue: dispatch_queue_t {
    return dispatch_get_main_queue()
  }
  
  class var backgroundQueue: dispatch_queue_t {
    return dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
  }
}
