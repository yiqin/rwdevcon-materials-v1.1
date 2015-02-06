//
//  FavoritesViewController.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 12/7/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import UIKit

class FavoritesViewController : UIViewController {
  @IBOutlet var tableView : UITableView!
  let dataSource = PhotoDataSource(favoritesOnly: true)
  
  //MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = NSLocalizedString("favorites", comment: "title for favorites view controller")
    
    //Set up the data source and delegate.
    tableView.dataSource = dataSource
    tableView.delegate = dataSource
    dataSource.tableView = tableView
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    if (segue.identifier == "ShowDetail") {
      // pass data to next view
      let tappedCell = sender as PhotoTableViewCell
      let detail = segue.destinationViewController as PhotoDetailViewController
      detail.photo = dataSource.photoForCell(tappedCell)
    }
  }
  
  //MARK: IBActions
  
  @IBAction func close() {
    dismissViewControllerAnimated(true, completion: nil)
  }
}
