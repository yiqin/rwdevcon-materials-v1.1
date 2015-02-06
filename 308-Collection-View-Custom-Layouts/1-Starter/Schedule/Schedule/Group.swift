//
//  Group.swift
//  Schedule
//
//  Created by Mic Pringle on 29/01/2015.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import Foundation

class Group {
  
  var header: String
  var sessions: [Session] = []
  
  init(header: String, sessions: [Session]) {
    self.header = header
    self.sessions = sessions
  }
  
  convenience init(dictionary: NSDictionary) {
    let header = dictionary["Header"] as String
    var sessions: [Session] = []
    let dictionaries = dictionary["Sessions"] as [NSDictionary]
    for dictionary in dictionaries {
      let session = Session(dictionary: dictionary)
      sessions.append(session)
    }
    self.init(header: header, sessions: sessions)
  }
  
}