//
//  MasterViewController.swift
//  CourseCatalog
//
//  Created by Saul Mora on 12/6/14.
//  Copyright (c) 2014 Magical Panda. All rights reserved.
//

import UIKit
import Argo
import Runes

@objc class CourseListViewController: UIViewController, UITableViewDelegate
{
  @IBOutlet var tableView : UITableView!
  @IBOutlet var dataSource : CatalogDataSource!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad
    {
      self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
    }
  }
  
  override func viewDidAppear(animated:Bool) {
    super.viewDidAppear(animated)
    if let selectedIndexPath = tableView.indexPathForSelectedRow() {
      tableView.deselectRowAtIndexPath(selectedIndexPath, animated: animated)
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showCourse"
    {
      prepareShowCourseSegue <^>
        segue <*>
        tableView.indexPathForSelectedRow()
    }
  }
  
  func prepareShowCourseSegue(segue:UIStoryboardSegue)(toDetailsAtIndexPath indexPath:NSIndexPath)
  {
    configureCourseViewController <^>
      (
        cast(segue.destinationViewController) >>-
          topController >>-
        cast
      ) <*>
    indexPath
  }
  
  func configureCourseViewController(controller:CourseViewController)(indexPath:NSIndexPath)
  {
    let object = dataSource.courseAtIndexPath(indexPath)
    controller.course = object
    controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
    controller.navigationItem.leftItemsSupplementBackButton = true
  }
}
