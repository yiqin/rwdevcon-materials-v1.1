//
//  GibGabDetailViewController.swift
//  GibGab
//
//  Created by Fosco Marotto on 12/11/14.
//  Copyright (c) 2014 RWDevCon. All rights reserved.
//

import Parse
import ParseUI

class GabRepliesViewController: PFQueryTableViewController {
    
  var GabObject : PFObject?
  let className : String = "GabReplies"

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
    
    // (TODO:LAB) Remove this and add code to properly constrain and order the query
    query.whereKey("invalid", equalTo: true)
    
    return query;
  }
    
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("GabReplyCell") as GabReplyCell
    
    // (TODO:LAB) Use the GabReplyObject to configure the cell
    
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    var destination = segue.destinationViewController as NewGabReplyViewController
    destination.GabObject = GabObject
  }
}
