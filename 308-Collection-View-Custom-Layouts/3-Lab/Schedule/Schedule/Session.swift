//
//  Session.swift
//  Schedule
//
//  Created by Mic Pringle on 29/01/2015.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import Foundation

class Session {
  
  var time: String
  var name: String
  var room: String
  var hour: Float
  var offset: Float
  var length: Float
  
  
  init(time: String, name: String, room: String, hour: Float, offset: Float, length: Float) {
    self.time = time
    self.name = name
    self.room = room
    self.hour = hour
    self.offset = offset
    self.length = length
  }
  
  convenience init(dictionary: NSDictionary) {
    let time = dictionary["Time"] as String
    let name = dictionary["Name"] as String
    let room = dictionary["Room"] as String
    let hour = dictionary["Hour"] as NSString
    let offset = dictionary["Offset"] as NSString
    let length = dictionary["Length"] as NSString
    self.init(time: time, name: name, room: room, hour: hour.floatValue, offset: offset.floatValue, length: length.floatValue)
  }
  
}
