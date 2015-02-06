//
//  JSONParserTests.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 11/30/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

//Import testing + iOS frameworks
import UIKit
import XCTest

//Import the module you wish to test.
import FlickrSearcher

class JSONParserTests : BaseTests {
  
  func testParsingPhotoListAgainstJSONFromFile() {
    let expectation = expectationWithDescription("Parsed Photos From File!")
    MockAPIController().fetchPhotosForTag(FlickrParameterValue.TestTag.rawValue) {
      (success, result) -> Void in
      if let unwrappedResult = result {
        let parsedPhotos = FlickrJSONParser.parsePhotoListDictionary(unwrappedResult)
        if let unwrappedPhotos = parsedPhotos {
          XCTAssertEqual(unwrappedPhotos.count, 100, "Did not parse 100 photos!")
        } else {
          XCTFail("No Parsed Photos for you!")
        }
      } else {
        XCTFail("No result!")
      }
      
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(localTimeout, nil)
  }
  
  //TODO: Add user parsing test
}
