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
  
    // (TODO:LAB) Save the reply and move the following code into the completion block
    
    activity.stopAnimating()
    activity.removeFromSuperview()
    navigationController?.popViewControllerAnimated(true)
  }
    
}
