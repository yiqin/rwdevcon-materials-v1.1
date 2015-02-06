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

class ViewController: UIViewController, PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
  override func viewDidAppear(animated: Bool) {
    if (PFUser.currentUser() != nil) {
      self.performSegueWithIdentifier("goToMain", sender: self)
    }
  }

  @IBAction func didTapLogIn(sender: AnyObject) {

    var loginController = PFLogInViewController()
    loginController.fields = PFLogInFields.UsernameAndPassword
      | PFLogInFields.LogInButton
      | PFLogInFields.DismissButton
    loginController.delegate = self
    
    presentViewController(loginController, animated: true, completion: nil)
    
  }
    
  @IBAction func didTapSignUp(sender: AnyObject) {
    
    var signupController = PFSignUpViewController()
    signupController.fields = PFSignUpFields.UsernameAndPassword
      | PFSignUpFields.SignUpButton
      | PFSignUpFields.DismissButton
    signupController.delegate = self
    
    presentViewController(signupController, animated: true, completion: nil)
    
  }
  
  func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!) {
    signUpController.dismissViewControllerAnimated(true, completion: nil)
    performSegueWithIdentifier("goToMain", sender: self)
  }
  
}

