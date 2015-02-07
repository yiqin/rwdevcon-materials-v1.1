//
//  GibGabTableViewController.swift
//  GibGab
//
//  Created by Fosco Marotto on 12/11/14.
//  Copyright (c) 2014 RWDevCon. All rights reserved.
//

import Parse
import ParseUI

class GabsViewController: PFQueryTableViewController {

  let className : String = "Gabs"
    
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
    
  override init(style aStyle: UITableViewStyle, className aClassName: String!) {
    super.init(style: aStyle, className: aClassName)
        
    self.parseClassName = className
    self.pullToRefreshEnabled = true
    self.paginationEnabled = false
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    loadObjects()
  }
    
  override func queryForTable() -> PFQuery! {
    var query = PFQuery(className: className)
    
    // (TODO:DEMO) Remove this and add code to properly constrain and order the query
//    query.whereKey("invalid", equalTo: true)
    
    query.orderByDescending("createdAt")
    query.limit = 50 // 120 objects default value
    
    
    
    return query
  }
    
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("GabCell") as GabCell
    
    // (TODO:DEMO) Use the Parse Object to populate the cell
    
    var object = objectAtIndexPath(indexPath)
    cell.gabText.text = object["gabText"] as String!
    cell.gabVote.text = object["gabVotes"].stringValue
    cell.GabObject = object
    
    
    
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    if (segue.identifier == "toGabReplies") {
      var destination = segue.destinationViewController as GabRepliesViewController
        destination.GabObject = objectAtIndexPath(tableView.indexPathForSelectedRow())
    }
  }
    
  @IBAction func didTapLogOut(sender: AnyObject) {
    
    // (TODO:CHALLENGE) Use the logOut method of PFUser
    
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}