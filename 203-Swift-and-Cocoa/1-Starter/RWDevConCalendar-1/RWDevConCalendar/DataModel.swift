//
//  Session.swift
//  RWDevConCalendar
//
//  Created by Matt Galloway on 01/12/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation

enum Track {
  case Generic
  case Beginner
  case Intermediate
  case Advanced
}

struct Session {
  let title: String
  let speaker: String
  let description: String
  let start: NSDate
  let end: NSDate
  let track: Track
}

func createSessionFromJSON(json: JSON) -> Session {
  let title = json["title"].stringValue
  let speaker = json["speaker"].stringValue
  let description = json["description"].stringValue
  let start = NSDate(timeIntervalSince1970: json["start"].doubleValue)
  let end = NSDate(timeIntervalSince1970: json["end"].doubleValue)

  var track: Track
  switch json["track"].stringValue {
  case "Beginner":
    track = .Beginner
  case "Intermediate":
    track = .Intermediate
  case "Advanced":
    track = .Advanced
  default:
    track = .Generic
  }

  return Session(title: title, speaker: speaker, description: description, start: start, end: end, track: track)
}
