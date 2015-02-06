//
//  TodayViewController.swift
//  Counting Down
//
//  Created by Chris Wagner on 1/31/15.
//  Copyright (c) 2015 Ray Wenderlich LLC. All rights reserved.
//

import UIKit
import NotificationCenter
import CountdownKit

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet var tableView: UITableView!
    var targetDays = CoreDataController.sharedInstance.targetDays
        
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = CGSizeMake(0, 150)
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        targetDays = CoreDataController.sharedInstance.targetDays
        tableView.reloadData()
        completionHandler(NCUpdateResult.NewData)
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
        return cell
    }

}
