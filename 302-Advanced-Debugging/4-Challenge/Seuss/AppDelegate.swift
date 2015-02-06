//
//  AppDelegate.swift
//  Seuss
//
//  Created by Richard Turton on 13/11/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  var keyboardAppearObserver : AnyObject?
  var keyboardDisappearObserver : AnyObject?
  
  let coreDataStack = CoreDataStack()
  
  weak var keyboardDismissingOverlay : KeyboardDismissingOverlay?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    if let booksVC = (window?.rootViewController as? UINavigationController)?.topViewController as? BooksTableViewController {
      booksVC.coreDataStack = coreDataStack
    }
    
    keyboardAppearObserver = NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidShowNotification, object:nil, queue:NSOperationQueue.mainQueue(), usingBlock:{
      notification in
      
      if self.keyboardDismissingOverlay != nil {
        return
      }
      
      let overlay = KeyboardDismissingOverlay(frame:CGRectZero)
      overlay.backgroundColor = UIColor.clearColor()
      self.window?.rootViewController?.view.addSubview(overlay)
      overlay.frame = overlay.superview!.bounds
      if let userInfo = notification.userInfo {
        overlay.keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
      }
      self.keyboardDismissingOverlay = overlay
    })
    
    keyboardDisappearObserver = NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidHideNotification, object:nil, queue:NSOperationQueue.mainQueue(), usingBlock:{
      notification in
      self.keyboardDismissingOverlay?.removeFromSuperview()
      self.keyboardDismissingOverlay = nil
    })
    
    return true
  }
  
}

