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
    
    query.whereKey("gabParent", equalTo: GabObject)
    query.orderByAscending("createdAt")
    query.limit = 1000
    
    return query;
  }
    
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("GabReplyCell") as GabReplyCell
    
    var object = objectAtIndexPath(indexPath)
    cell.replyText.text = object["replyText"] as String!
    cell.replyUsername.text = object["replyUsername"] as String!
    
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    var destination = segue.destinationViewController as NewGabReplyViewController
    destination.GabObject = GabObject
  }
}
