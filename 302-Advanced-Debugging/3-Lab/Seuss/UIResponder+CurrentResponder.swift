//
//  UIResponder+CurrentResponder.swift
//  Seuss
//
//  Created by Richard Turton on 20/11/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

extension UIResponder {
  
  private struct CurrentResponder {
    static weak var currentResponder: UIResponder?
  }
  
  class func currentFirstResponder() -> UIResponder? {
    CurrentResponder.currentResponder = nil
    UIApplication.sharedApplication().sendAction("findFirstResponder:", to: nil, from: nil, forEvent: nil)
    return CurrentResponder.currentResponder
  }
  
  func findFirstResponder (sender : AnyObject?) {
    CurrentResponder.currentResponder = self
  }
}
