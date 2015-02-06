//
//  FlickrAPITests.swift
//  FlickrAPITests
//
//  Created by Ellen Shapiro on 11/14/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

//Import testing + iOS frameworks
import UIKit
import XCTest

//Import the module you wish to test.
import FlickrSearcher

class FlickrAPITests : BaseTests {
  
  var controller: FlickrAPIController = FlickrAPIController()
  
  //MARK: - Make sure you have signed up for Flickr Creds
  
  func testAPIKeyExists() {
    XCTAssertFalse(FlickrAuthCredential.APIKey.rawValue == "FIXME", "You need to add your Flickr API key!")
  }
  
  //MARK: - Sync vs. Async testing
  
  func testEchoEndpointResponding() {
    let expectation = expectationWithDescription("Finished echo!")
    
    controller.pingEchoEndpointWithCompletion {
      (success, result) -> Void in
      XCTAssertTrue(success, "Success was not true!")
      XCTAssertNotNil(result, "Result was nil!")
      
      //      XCTFail("HIT THIS METHOD!")
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(standardTimeout, handler: nil)
    NSLog("End of test method body")
  }
  
  func testEchoEndpointReturningSuccessAsync() {
    let expectation = expectationWithDescription("Finished echo!")
    
    controller.pingEchoEndpointWithCompletion {
      (success, result) -> Void in
      XCTAssertTrue(success, "Success was not true!")
      XCTAssertNotNil(result, "Result was nil!")
      
      if let unwrappedDict = result {
        XCTAssertTrue(FlickrJSONParser.isResponseOK(unwrappedDict), "Response is not OK!")
      } else {
        XCTFail("Dict did not unwrap!")
      }
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(standardTimeout, handler: nil)
  }
  
  //MARK: - Getting photos
  
  func testRetrievingPhotosForTagWithLotsOfResults() {
    let expectation = expectationWithDescription("Got photo results!")
    
    controller.fetchPhotosForTag(FlickrParameterValue.TestTag.rawValue) { (success, result : NSDictionary?) -> Void in
      
      XCTAssertTrue(success, "Success was not true!")
      XCTAssertNotNil(result, "Result was nil!")
      
      if let unwrappedDict: NSDictionary = result {
        XCTAssertTrue(FlickrJSONParser.isResponseOK(unwrappedDict), "Response is not OK!")
        let parsedPhotos = FlickrJSONParser.parsePhotoListDictionary(unwrappedDict)
        if let unwrappedParsedPhotos = parsedPhotos {
          XCTAssertEqual(unwrappedParsedPhotos.count, 100, "100 photos not returned!")
          for photo in unwrappedParsedPhotos {
            if !self.urlStringBecomesValidURL(photo.fullURLString) {
              XCTFail("Photo with ID \(photo.photoID) had invalid URL \(photo.fullURLString)")
            }
          }
        } else {
          XCTFail("No list of photos!")
        }
      } else {
        XCTFail("Top-level dict did not unwrap!")
      }
      
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(standardTimeout, handler: nil)
  }
  
  //MARK: - Getting user data

  //TODO: Add Test
}
