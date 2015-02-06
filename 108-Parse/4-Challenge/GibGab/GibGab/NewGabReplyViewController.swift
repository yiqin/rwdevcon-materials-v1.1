//
//  NewGabReplyViewController.swift
//  GibGab
//
//  Created by Fosco Marotto on 12/12/14.
//  Copyright (c) 2014 RWDevCon. All rights reserved.
//

import Parse

class NewGabReplyViewController: UIViewController {

  var GabObject : PFObject?
  @IBOutlet weak var replyText: UITextView!
    
  override func viewDidAppear(animated: Bool) {
    replyText.becomeFirstResponder()
  }
    
  @IBAction func didTapSend(sender: AnyObject) {
    if (replyText.text.isEmpty) {
      var button = sender as UIButton
      button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)      
      return
    }
    var activity = UIActivityIndicatorView()
    activity.hidesWhenStopped = true
    self.view.addSubview(activity)
    activity.startAnimating()
  
    PFAnalytics.trackEventInBackground("new-reply", block: nil)
    
    var reply = PFObject(className: "GabReplies")
    reply["replyText"] = replyText.text
    reply["replyUsername"] = PFUser.currentUser().objectForKey("username")
    reply["gabParent"] = GabObject
    
    reply.saveInBackgroundWithBlock {
      (success: Bool, error: NSError!) -> Void in
      activity.stopAnimating()
      activity.removeFromSuperview()
      self.navigationController?.popViewControllerAnimated(true)
    }

  }
    
}
