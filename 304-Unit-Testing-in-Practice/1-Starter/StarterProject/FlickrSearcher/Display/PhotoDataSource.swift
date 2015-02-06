//
//  PhotoDataSource.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 12/1/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import UIKit
import CoreData

/**
Isolated DataSource/Delegate/FetchedResultsControllerDelegate that can be reused in multiple tableviews.
*/
class PhotoDataSource : NSObject, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
  
  let resultsController: NSFetchedResultsController
  var downloader = FlickrPhotoDownloader()
  var tableView: UITableView!
  var didRegister = false
  var userIDsToDownload = [String]()
  var loadingUser = false
  
  //MARK: - UITableViewDataSource
  
  /**
  Designated initializer.
  
  :param: favoritesOnly true If this data source should only show favorites, false if it should show all results.
  :returns: The initialized instance.
  */
  required init(favoritesOnly: Bool) {
    if ShouldUseFakeDataInApplication {
      downloader = MockPhotoDownloader()
    }
    
    let fetchRequest = NSFetchRequest(entityName: Photo.flk_className())
    
    //TODO: Figure out how to not hard-code theese
    
    if favoritesOnly {
      let predicate = NSPredicate(format: "%K == YES", "isFavorite")
      fetchRequest.predicate = predicate
    }
    
    let sortByID = NSSortDescriptor(key: "photoID", ascending: false)
    fetchRequest.sortDescriptors = [sortByID]
    
    resultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
      managedObjectContext: CoreDataStack.sharedInstance().mainContext(),
      sectionNameKeyPath: nil,
      cacheName: nil)
    super.init()
    reloadFRC()
    
    //Can't call self before super.init()
    resultsController.delegate = self
  }
  
  //MARK: Helper functions
  
  func reloadFRC() {
    var error: NSError?
    resultsController.performFetch(&error)
    
    if let unwrappedError = error {
      NSLog("ERROR: \(unwrappedError)")
    }
  }
  
  func photoForCell(cell: PhotoTableViewCell) -> Photo {
    let indexPath = tableView.indexPathForCell(cell)
    return resultsController.objectAtIndexPath(indexPath!) as Photo
  }
  
  //MARK: - UITableViewDataSource
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let objects = (resultsController.sections?[section] as? NSFetchedResultsSectionInfo)?.numberOfObjects
    return objects ?? 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(PhotoTableViewCell.cellIdentifier(), forIndexPath: indexPath) as PhotoTableViewCell
    
    //Cancel any previous operations setting to this
    downloader.cancelSetToImageView(cell.photoImageView!)
    
    let photoAtIndex = resultsController.objectAtIndexPath(indexPath) as Photo
    
    cell.titleLabel.text = photoAtIndex.title
    
    if let username = photoAtIndex.owner.name {
      cell.userNameLabel.text = username
    } else {
      cell.userNameLabel.text = photoAtIndex.owner.userID
      
      //Need some details!
      //TODO: Uncomment in Challenge!
//      addUserIDToDownloadArray(photoAtIndex.owner.userID)
    }
    
    if photoAtIndex.isFavorite {
      cell.favoriteIcon.tintColor = UIColor.redColor()
    } else {
      cell.favoriteIcon.tintColor = UIColor.clearColor()
    }
    
    downloader.setImageFromURLString(photoAtIndex.thumbnailURLString, toImageView: cell.photoImageView!)
    
    return cell
  }
  
  //MARK: - UITableViewDelegate
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated:true)
  }
  
  //MARK: - NSFetchedResultsControllerDelegate
  
  func controllerWillChangeContent(controller : NSFetchedResultsController) {
    tableView.beginUpdates()
  }
  
  func controller(controller: NSFetchedResultsController,
    didChangeObject anObject: AnyObject,
    atIndexPath indexPath: NSIndexPath?,
    forChangeType type: NSFetchedResultsChangeType,
    newIndexPath: NSIndexPath?) {
      switch type {
      case .Insert:
        tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
      case .Delete:
        tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
      case .Update:
        tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
      case .Move:
        tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
      }
  }
  
  func controllerDidChangeContent(controller: NSFetchedResultsController) {
    tableView.endUpdates()
  }
  
  //MARK: - Downloading user information
  
  //TODO: Uncomment in Challenge!
  
//  func addUserIDToDownloadArray(userID: String) {
//    if !contains(userIDsToDownload, userID) {
//      userIDsToDownload.append(userID)
//    } //else this user is already in the download queue
//    
//    if !loadingUser {
//      loadNextUserIfExists()
//    } //else user will load after current item finishes
//  }
//  
//  func loadNextUserIfExists() {
//    let first = userIDsToDownload.first
//    if let unwrappedFirst = first {
//      userIDsToDownload.removeAtIndex(0)
//      getUserDetails(unwrappedFirst)
//    } //else nothing in the array
//  }
//  
//  func getUserDetails(userID: String) {
//    self.loadingUser = true
//    FlickrAPIController().fetchDataForUser(userID) { [unowned self] (success, result) -> Void in
//      self.loadingUser = false
//      if let unwrappedResult = result {
//        FlickrJSONParser.parseUserDictionary(unwrappedResult)
//        CoreDataStack.sharedInstance().saveMainContext()
//        
//        if let visiblePaths = self.tableView.flk_visibleIndexPaths() {
//          self.tableView.reloadRowsAtIndexPaths(visiblePaths, withRowAnimation: .None)
//        } //else nothing is visible.
//        
//        self.loadNextUserIfExists()
//      } //else did not load.
//    }
//  }
}