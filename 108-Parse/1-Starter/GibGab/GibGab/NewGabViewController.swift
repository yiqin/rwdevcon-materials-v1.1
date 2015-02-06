//
//  NewGibGabViewController.swift
//  GibGab
//
//  Created by Fosco Marotto on 12/11/14.
//  Copyright (c) 2014 RWDevCon. All rights reserved.
//

import Parse

class NewGabViewController: UIViewController, UITextViewDelegate {

  @IBOutlet weak var gabText: UITextView!
    
  override func viewDidAppear(animated: Bool) {
    gabText.becomeFirstResponder()
  }
    
  @IBAction func didTapSend(sender: AnyObject) {
    if (gabText.text.isEmpty) {
      var button = sender as UIButton
      button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
      return
    }
      
    var activity = UIActivityIndicatorView()
    self.view.addSubview(activity)
    activity.startAnimating()

    // (TODO:DEMO) Save Gab data to Parse
    // The following will then be moved to a continuation block that runs after the save
      
    activity.stopAnimating()
    activity.removeFromSuperview()
    navigationController?.popViewControllerAnimated(true)
  }
}
