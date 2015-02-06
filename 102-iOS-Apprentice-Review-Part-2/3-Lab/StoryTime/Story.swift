//
//  Story.swift
//  StoryTime
//
//  Created by Brian Moakley on 1/30/15.
//  Copyright (c) 2015 Tammy Coron. All rights reserved.
//

import Foundation

enum StoryType {
  case zombies, vampires
}

class Story {
  
  var title: String
  var name: String?
  var verb: String?
  var number: Int?
  var winStory: String?
  var loseStory: String?
  var type: StoryType
  
  init(title: String, winStory: String, loseStory:String, type: StoryType) {
    self.title = title
    self.winStory = winStory
    self.loseStory = loseStory
    self.type = type
  }
  
  func generateStory(monstersWin: Bool) -> String {
    var storyText = ""
    
    if monstersWin {
      if let winStory = winStory {
        storyText = winStory
      }
    } else {
      if let loseStory = loseStory {
        storyText = loseStory
      }
    }
    var monsters = "zombies"
    if type == .vampires {
      monsters = "vampires"
    }
    
    if verb != nil {
      storyText = replaceText("<verb>", withText: verb!, inString: storyText)
    }
    if number != nil {
      storyText = replaceText("<number>", withText: String(number!), inString: storyText)
    }
    if name != nil {
      storyText = replaceText("<name>", withText: name!, inString: storyText)
    }
    storyText = replaceText("<monsters>", withText: monsters, inString: storyText)
    
    return storyText
  }
  
  private func replaceText(text: String, withText: String, inString: String) -> String {
    return inString.stringByReplacingOccurrencesOfString(text, withString: withText, options: NSStringCompareOptions.LiteralSearch, range: nil)
  }
  
}