//
//  NewStoryViewController.swift
//  StoryTime
//
//  Created by Brian Moakley on 1/30/15.
//  Copyright (c) 2015 Tammy Coron. All rights reserved.
//

import UIKit

class NewStoryViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

  var newStory: Story?
  var didCancel: Bool = false
  
  @IBOutlet weak var backgroundImage: UIImageView!
  @IBOutlet weak var losingStory: UITextView!
  @IBOutlet weak var winningStory: UITextView!
  @IBOutlet weak var storyTitle: UITextField!
  @IBOutlet weak var monsterType: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tapGestureRecognizer)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func textViewShouldBeginEditing(textView: UITextView) -> Bool {
    textView.resignFirstResponder()
    return true
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
  
  func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    if text == "\n" {
      dismissKeyboard()
    }
    return true;
  }
  
  @IBAction func save(sender: AnyObject) {
    if !storyTitle.text.isEmpty && !winningStory.text.isEmpty && !losingStory.text.isEmpty {
      var storyType: StoryType!
      if monsterType.selectedSegmentIndex == 0 {
        storyType = StoryType.zombies
      } else {
        storyType = StoryType.vampires
      }
      newStory = Story(title: storyTitle.text, winStory: winningStory.text, loseStory: losingStory.text, type: storyType)
      performSegueWithIdentifier("DismissNewStory", sender: nil)
    } else {
      let alert = UIAlertController(title: "Validation Error", message: "Please fill out all of the fields.", preferredStyle: UIAlertControllerStyle.Alert)
      let alertAction = UIAlertAction(title: "OK", style: .Default, handler:nil)
      alert.addAction(alertAction)
      presentViewController(alert, animated: false, completion:nil)
    }
  }
  
  @IBAction func cancelStory(sender:AnyObject!) {
    didCancel = true
    performSegueWithIdentifier("DismissNewStory", sender: nil)
  }
  
  @IBAction func changeMonsterType(sender:UISegmentedControl!) {
    if sender.selectedSegmentIndex == 0 {
      backgroundImage.image = UIImage(named: "zombies")
    } else {
      backgroundImage.image = UIImage(named: "vampires")
    }
  }

}
