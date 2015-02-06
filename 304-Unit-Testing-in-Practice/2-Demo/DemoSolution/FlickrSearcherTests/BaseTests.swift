//
//  BaseTests.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 12/1/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

//Import testing + iOS frameworks
import UIKit
import XCTest

//Import the module you wish to test.
import FlickrSearcher

/**
Base class for testing.
*/
class BaseTests : XCTestCase {
  
  let standardTimeout: NSTimeInterval = 5.0
  let localTimeout: NSTimeInterval = 2
  
  //MARK: Instance setup/teardown
  
  override func setUp() {
    super.setUp()
    
    //Nuke the database before every test.
    CoreDataStack.sharedInstance().isTesting = true
    CoreDataStack.sharedInstance().resetDatabase()
  }
  
  /**
  Verifies that a given string becomes a valid URL.
  
  :param: urlString The string to check  
  :returns: true if the string can become a URL, false if not.
  */
  func urlStringBecomesValidURL(urlString: String) -> Bool {
    let url = NSURL(string: urlString)
    if let unwrappedURL = url {
      return true
    } else {
      return false
    }
  }
}
