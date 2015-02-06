//
//  AppDelegate.swift
//  GibGab
//
//  Created by Fosco Marotto on 12/11/14.
//  Copyright (c) 2014 RWDevCon. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    // Use your own Application Id and Client Key here:
    Parse.setApplicationId("RejUfvOGKeZMH9aFtZizEkl9SZ9f9CVPwfVIkjbs",
      clientKey: "Gx8qjENNX2c8phKxuKOkQHhQ7QKeDktJJIbIZD9e")
    PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, nil)
        
    return true
  }
}

