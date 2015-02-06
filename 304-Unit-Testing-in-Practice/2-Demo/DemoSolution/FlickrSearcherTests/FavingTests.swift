//
//  FavingTests.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 12/8/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

//Import testing + iOS frameworks
import UIKit
import XCTest
import CoreData

//Import the module you wish to test.
import FlickrSearcher

class FavingTests : BaseTests {
  
  override func setUp() {
    super.setUp()
    
    let expectation = expectationWithDescription("Imported fake data!")
    MockAPIController().fetchPhotosForTag(FlickrParameterValue.TestTag.rawValue) {
      (success, result) -> Void in
      if let unwrappedResult = result {
        FlickrJSONParser.parsePhotoListDictionary(unwrappedResult)
        CoreDataStack.sharedInstance().saveMainContext()
      } else {
        XCTFail("No result from API controller!")
      }
      
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(localTimeout, handler: nil)
  }
  
  func testFavoritingTheFirstItemRetrievedFromCoreDataWorks() {
    let allPhotosFetchRequest = Photo.flk_fetchRequestWithPredicate(nil)
    var error: NSError?
    let allPhotos = CoreDataStack.sharedInstance()
                                 .mainContext()
                                 .executeFetchRequest(allPhotosFetchRequest, error: &error)
    
    if let unwrappedError = error {
      XCTFail("Error fetching all photos: \(unwrappedError)")
    } else {
      if let unwrappedAll = allPhotos as? [Photo] {
        let firstPhoto = unwrappedAll.first!
        firstPhoto.isFavorite = true
        CoreDataStack.sharedInstance().saveMainContext()
        
        //Update the fetch request to add a predicate
        allPhotosFetchRequest.predicate = NSPredicate(format: "%K == YES", "isFavorite")
        let faves = CoreDataStack.sharedInstance()
                                 .mainContext()
                                 .executeFetchRequest(allPhotosFetchRequest, error: &error)
        if let unwrappedFaveError = error {
          XCTFail("Error fetching favorite photos:\(unwrappedFaveError)")
        } else {
          if let unwrappedFaves = faves as? [Photo] {
            XCTAssertEqual(unwrappedFaves.count, 1, "Unwrapped faves was not 1 object, it was \(unwrappedFaves.count)")
            let firstFave = unwrappedFaves.first!
            XCTAssertEqual(firstPhoto.photoID, firstFave.photoID, "Faved photo is not the same!")
          } else {
            XCTFail("No faves found!")
          }
        }
      } else {
        XCTFail("No photos found!")
      }
    }
  }
}
