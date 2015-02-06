//
//  TodayViewController.swift
//  Counting Down
//
//  Created by Chris Wagner on 12/15/14.
//  Copyright (c) 2014 Ray Wenderlich LLC. All rights reserved.
//

import UIKit
import NotificationCenter
import CountdownKit

class TodayViewController: UIViewController, NCWidgetProviding {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var addCountdownButton: UIButton!
  
  private var expandedIndexPath: NSIndexPath?
  var targetDays = CoreDataController.sharedInstance.targetDays
  
  override func viewDidLoad() {
    super.viewDidLoad()

    if targetDays.count == 0 {
      preferredContentSize = CGSize(width: 0, height: 50)
      addCountdownButton.hidden = false
      tableView.hidden = true
    } else {
      addCountdownButton.hidden = true
      tableView.hidden = false
      calculatePreferredSize()
    }
    
  }
  
  @IBAction func addCountdown(sender: AnyObject) {
    let url = NSURL(string: "countdown://add")!
    extensionContext?.openURL(url, completionHandler: nil)
  }
  
  func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  override func didReceiveMemoryWarning() {
    for cell in tableView.visibleCells() as [TargetDayCell] {
      cell.imageHidden = true
    }
  }
  
  func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
    targetDays = CoreDataController.sharedInstance.targetDays
    tableView.reloadData()
    completionHandler(NCUpdateResult.NewData)
  }
  
  private func calculatePreferredSize() {
    if expandedIndexPath == nil {
      preferredContentSize = CGSize(width: 0, height: min(targetDays.count * 50, 150))
    } else {
      preferredContentSize = CGSize(width: 0, height: 150)
    }
  }
  
}

extension TodayViewController: UITableViewDataSource, UITableViewDelegate {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let rowCount = targetDays.count
    
    return rowCount
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TargetDay") as TargetDayCell
    let targetDay = targetDays[indexPath.row]
    cell.targetDay = targetDay
    // 1
    if let expandedIndexPath = expandedIndexPath {
      if indexPath.compare(expandedIndexPath) == .OrderedSame {
        // 2
        cell.imageHidden = false
      }
    } else {
      // 3
      cell.imageHidden = true
    }
    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if let expandedIndexPath = expandedIndexPath {
      if indexPath.compare(expandedIndexPath) == .OrderedSame {
        return 150
      }
    }
    
    return 50
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let cell = tableView.cellForRowAtIndexPath(indexPath) as TargetDayCell
    // 1
    if let expandedIndexPath = expandedIndexPath {
      // 2
      if indexPath.compare(expandedIndexPath) == .OrderedSame {
        self.expandedIndexPath = nil
      } else {
        self.expandedIndexPath = indexPath
      }
    } else {
      // 3
      self.expandedIndexPath = indexPath
    }
    
    // 4
    calculatePreferredSize()
    tableView.beginUpdates()
    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    tableView.endUpdates()
    
    // 5
    if expandedIndexPath == nil {
      tableView.setContentOffset(CGPointZero, animated: true)
    } else {
      tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
    }
  }
}