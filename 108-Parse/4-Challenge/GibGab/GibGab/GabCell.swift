//
//  GibGabCell.swift
//  GibGab
//
//  Created by Fosco Marotto on 12/11/14.
//  Copyright (c) 2014 RWDevCon. All rights reserved.
//

import Parse

class GabCell: UITableViewCell {
  
  @IBOutlet weak var gabText: UILabel!
  @IBOutlet weak var gabVote: UILabel!
  @IBOutlet weak var upButton: UIButton!
  @IBOutlet weak var downButton: UIButton!
  var GabObject : PFObject?
    
  @IBAction func didTapVoteUp(sender: AnyObject) {
      
    upButton.hidden = true
    downButton.hidden = true
    GabObject?.incrementKey("gabVotes", byAmount: 1)
    GabObject?.addUniqueObject(
      PFUser.currentUser().objectId, forKey: "gabVoters")
    gabVote.text = GabObject?.objectForKey("gabVotes").stringValue
    GabObject?.saveEventually(nil)
    
  }
    
  @IBAction func didTapVoteDown(sender: AnyObject) {
   
    upButton.hidden = true
    downButton.hidden = true
    GabObject?.incrementKey("gabVotes", byAmount: -1)
    GabObject?.addUniqueObject(
      PFUser.currentUser().objectId, forKey: "gabVoters")
    gabVote.text = GabObject?.objectForKey("gabVotes").stringValue
    GabObject?.saveEventually(nil)
    
  }
}
