//
//  MockFlickrAPITests.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 12/12/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import FlickrSearcher

class MockFlickrAPITests : FlickrAPITests {
  
  override func setUp() {
    super.setUp()
    
    //Replace the standard controller with a mock API controller.
    controller = MockAPIController()
  }
}