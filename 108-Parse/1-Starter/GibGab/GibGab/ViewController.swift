//
//  ViewController.swift
//  GibGab
//
//  Created by Fosco Marotto on 12/11/14.
//  Copyright (c) 2014 RWDevCon. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
  override func viewDidAppear(animated: Bool) {
    if (PFUser.currentUser() != nil) {
      self.performSegueWithIdentifier("goToMain", sender: self)
    }
  }

  @IBAction func didTapLogIn(sender: AnyObject) {

    // (TODO:CHALLENGE) Add code to launch PFLogInViewController just as PFSignUpViewController is used below
      
  }
    
  @IBAction func didTapSignUp(sender: AnyObject) {
      
    // (TODO:DEMO) Add code to launch PFSignUpViewController
      
  }
}

