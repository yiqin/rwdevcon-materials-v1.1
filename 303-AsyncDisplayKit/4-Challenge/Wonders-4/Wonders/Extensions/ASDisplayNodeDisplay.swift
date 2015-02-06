//
//  ASDisplayNodeDisplay.swift
//  Wonders
//
//  Created by Rene Cacheaux on 1/28/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

extension ASDisplayNode {
  func preDisplay() {
    if (layer.contents != nil) {
      return
    }
    dispatch_async(dispatch_get_main_queue()) {
      self.layer.setNeedsLayout()
      self.layer.layoutIfNeeded()
      self.layer.setNeedsDisplay()
      self.layer.displayIfNeeded()
    }
  }
}