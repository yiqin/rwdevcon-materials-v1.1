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
      
    // (TODO:DEMO) Add code to increment the score and save the Gab
        
  }
    
  @IBAction func didTapVoteDown(sender: AnyObject) {
   
    // (TODO:CHALLENGE) Add code to decrement the score and save the Gab
    
  }
}
