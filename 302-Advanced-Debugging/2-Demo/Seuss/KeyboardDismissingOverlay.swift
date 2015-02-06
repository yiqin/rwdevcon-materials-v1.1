//
//  KeyboardDismissingOverlay.swift
//  Seuss
//
//  Created by Richard Turton on 20/11/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

class KeyboardDismissingOverlay : UIView {
  
  var keyboardFrameObserver : AnyObject!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    keyboardFrameObserver = observeKeyboard()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    keyboardFrameObserver = observeKeyboard()
  }
  
  private func observeKeyboard() -> AnyObject {
    return NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidChangeFrameNotification, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: {
      [unowned self]
      notification in
      if let userInfo = notification.userInfo {
        self.keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
      }
    })
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(keyboardFrameObserver)
  }
  
  var keyboardFrame: CGRect!
  
  override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
    
    // Should this touch go to the keyboard?
    let keyboardRect = convertRect(keyboardFrame, fromView:nil)
    if CGRectContainsPoint(keyboardRect, point) {
      return false
    }
    
    // Is this touch on the current first responder?
    
    if let firstResponder = UIResponder.currentFirstResponder() as? UIView {
      let location = firstResponder.convertPoint(point, fromView:self)
      if !CGRectContainsPoint(firstResponder.bounds, location) {
        // If we resign first responder immediately, button clicks etc. are not passed through.
        dispatch_after(
          dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(Double(0.1) * Double(NSEC_PER_SEC))
          ),
          dispatch_get_main_queue(), {
            // We may also have moved to another first responder, in which case don't do anything
            if firstResponder.isFirstResponder() {
              firstResponder.resignFirstResponder()
            }
        })
      }
    }
    return false
  }
}

