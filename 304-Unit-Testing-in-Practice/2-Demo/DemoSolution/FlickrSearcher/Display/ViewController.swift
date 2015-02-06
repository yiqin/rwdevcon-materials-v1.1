//
//  ViewController.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 11/14/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var tableView : UITableView!
  let dataSource = PhotoDataSource(favoritesOnly: false)
  
  //MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = NSLocalizedString("tag: ", comment: "Title of tag") + FlickrParameterValue.TestTag.rawValue
    
    //Set up the data source and delegate.
    tableView.dataSource = dataSource
    tableView.delegate = dataSource
    dataSource.tableView = tableView
    
    //Load you some cats from Flickr.
    goGetSomeCats()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    if (segue.identifier == "ShowDetail") {
      // pass data to next view
      let tappedCell = sender as PhotoTableViewCell
      let detail = segue.destinationViewController as PhotoDetailViewController
      detail.photo = dataSource.photoForCell(tappedCell)
    }
  }
  
  //MARK: Cat Fetching
  
  func goGetSomeCats() {
    //Hit the Flickr API and grab a list of cat photos.
    var controller = FlickrAPIController()
    
    if ShouldUseFakeDataInApplication {
      controller = MockAPIController()
    }
    
    controller.fetchPhotosForTag(FlickrParameterValue.TestTag.rawValue) { (success, result) -> Void in
      if let unwrappedResult = result {
        FlickrJSONParser.parsePhotoListDictionary(unwrappedResult)
        CoreDataStack.sharedInstance().saveMainContext()
      }
    }
  }
}

