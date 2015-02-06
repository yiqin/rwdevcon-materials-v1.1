//
//  TableViewCatalogDataSource.swift
//  CourseCatalog
//
//  Created by Saul Mora on 12/23/14.
//  Copyright (c) 2014 Magical Panda. All rights reserved.
//

import UIKit
import CoreData

class CatalogTableViewDataSource : NSObject, CatalogDataSourceDelegate, UITableViewDataSource
{
  @IBOutlet var catalogDataSource : CatalogDataSource!
  @IBOutlet var tableView : UITableView!
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return catalogDataSource.courses.sections?.count ?? 0
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    let courses = catalogDataSource.courses
    let coursesInSection = courses.sections?[section] as NSFetchedResultsSectionInfo?
    let courseCount = coursesInSection?.numberOfObjects ?? 0
    return courseCount
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
    
    let object = catalogDataSource.courseAtIndexPath(indexPath) as TableViewCellDisplayable
    cell.textLabel?.text = object.displayDescription
    return cell
  }
  
  func dataSourceWillChangeContent(dataSource:CatalogDataSource) {
    tableView.beginUpdates()
  }
  
  func dataSourceDidAddNewObject(dataSource:CatalogDataSource, atIndexPath indexPath:NSIndexPath)
  {
    tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
  }
  
  func dataSourceDidChangeContent(dataSource:CatalogDataSource) {
    tableView.endUpdates()
  }
}

