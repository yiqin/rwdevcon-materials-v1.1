//
//  TableViewController-FetchedResults.swift
//  Seuss
//
//  Created by Richard Turton on 18/11/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation
import UIKit
import CoreData

typealias DequeueCell = (tableView: UITableView, indexPath:NSIndexPath) -> UITableViewCell
typealias ConfigureCell = (cell: UITableViewCell, indexPath:NSIndexPath, object:AnyObject!) -> Void

class FetchedResultsDataSource : NSObject, UITableViewDataSource , NSFetchedResultsControllerDelegate {
  var resultsController : NSFetchedResultsController? {
    didSet {
      resultsController?.performFetch(nil)
      resultsController?.delegate = self
      oldValue?.delegate = nil
    }
  }
  
  var configureCell : ConfigureCell! = nil
  var dequeueCell : DequeueCell! = nil
  var tableView : UITableView! = nil
  
  // MARK: Table view data source
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return resultsController?.sections?.count ?? 0
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (resultsController?.sections?[section] as? NSFetchedResultsSectionInfo)?.numberOfObjects ?? 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = dequeueCell(tableView:tableView,indexPath:indexPath)
    configureCell(cell:cell, indexPath:indexPath, object:resultsController?.objectAtIndexPath(indexPath))
    return cell
  }
  
  // MARK: Fetched results controller delegate
  func controllerWillChangeContent(controller : NSFetchedResultsController) {
    tableView.beginUpdates()
  }
  
  func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
    
    switch type {
    case .Insert : tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation:.Fade)
    case .Delete: tableView.deleteSections(NSIndexSet(index:sectionIndex), withRowAnimation: .Fade)
    case .Move: break
    case .Update : break
    }
  }
  
  func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    switch type {
    case .Insert: tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
    case .Delete: tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
    case .Update:
      configureCell(cell: tableView.cellForRowAtIndexPath(indexPath!)!, indexPath:indexPath!, object: anObject)
    case .Move:
      tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
      tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
    }
  }
  
  func controllerDidChangeContent(controller: NSFetchedResultsController) {
    tableView.endUpdates()
  }
}