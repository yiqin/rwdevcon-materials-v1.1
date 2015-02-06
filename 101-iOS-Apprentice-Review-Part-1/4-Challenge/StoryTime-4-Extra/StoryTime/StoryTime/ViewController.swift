//
//  ViewController.swift
//  StoryTime
//
//  Created by Tammy Coron on 11/17/14.
//  Copyright (c) 2014 Tammy Coron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: Properties
  var currentNumber = 50
  var currentSwitchValue = true
  var storyType = 0
  var monsters = "zombies"
  
  @IBOutlet weak var backgroundImage: UIImageView! // background image
  @IBOutlet weak var segmentedControl: UISegmentedControl! // story selection
  @IBOutlet weak var textField1: UITextField! // name
  @IBOutlet weak var textField1b: UITextField! // name b
  @IBOutlet weak var textField2: UITextField! // verb
  @IBOutlet weak var sliderControl: UISlider! // number
  @IBOutlet weak var switchControl: UISwitch! // win or lose
  @IBOutlet weak var textview: UITextView! // generated story
  @IBOutlet weak var button: UIButton! // generate story
  
  /* needed for lab */
  @IBOutlet weak var numberLabel: UILabel! // label for number
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textview.layer.borderColor = UIColor.darkGrayColor().CGColor
    textview.layer.borderWidth = 1.0
    
    /* needed for lab */
    numberLabel.text = "Number (\(currentNumber))"
    
    /* needed for challenge : validation b */
    textField1.delegate = self
    textField1b.delegate = self
    textField2.delegate = self
    checkValidationStatus()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func segmentedControllerChanged(sender: UISegmentedControl) {
    println("\(__FUNCTION__)")
    
    storyType = sender.selectedSegmentIndex
    
    var image : UIImage!
    
    switch storyType {
    case 0: // zombies
      image = UIImage(named:"zombies")
      monsters = "zombies"
    case 1: // vampires
      image = UIImage(named:"vampires")
      monsters = "vampires"
      /* needed for lab : extra time */
    case 2: // aliens
      image = UIImage(named:"aliens")
      monsters = "aliens"
    default:
      sender.tag = 0
    }
    
    resetStory()
    backgroundImage.image = image
  }
  
  @IBAction func sliderMoved(sender: UISlider) {
    println("\(__FUNCTION__)")
    
    currentNumber = lroundf(sender.value)
    
    /* needed for lab */
    numberLabel.text = "Number (\(currentNumber))"
  }
  
  @IBAction func switchValueChanged(sender: UISwitch) {
    println("\(__FUNCTION__)")
    
    if (sender.on) {
      currentSwitchValue = true
    } else {
      currentSwitchValue = false
    }
  }
  
  @IBAction func generateStory(sender: UIButton) {
    println("\(__FUNCTION__)")
    
    /* needed for challenge : validation a */
    if (textField1.text.isEmpty || textField2.text.isEmpty) {
      showAlert()
      return
    }
    
    switch sender.tag {
    case 1:
      sender.tag = 2
      sender.setTitle("Start Over", forState: UIControlState.Normal)
      populateStory()
    case 2:
      sender.tag = 1
      sender.setTitle("Generate Story", forState: UIControlState.Normal)
      resetStory()
    default:
      sender.tag = 0
    }
  }
  
  func populateStory() {
    println("\(__FUNCTION__)")
    
    if (currentSwitchValue) {
      textview.text = "\(textField1.text) and \(textField1b.text) entered the room and saw \(currentNumber) \(monsters)! \(textField1.text) and \(textField1b.text) \(textField2.text) down the hall. Sadly, \(textField1.text) and \(textField1b.text) were killed by all of the \(monsters)! \n\nPoor \(textField1.text) and \(textField1b.text). \n\nBetter luck next time!"
    } else {
      textview.text = "\(textField1.text) and \(textField1b.text) entered the room and saw \(currentNumber) \(monsters)! \(textField1.text) and \(textField1b.text) \(textField2.text) down the hall. Without missing a beat, \(textField1.text) and \(textField1b.text) killed all of the \(monsters)! \n\nFantastic! \n\nOur heros will live to fight another day."
    }
  }
  
  func resetStory() {
    println("\(__FUNCTION__)")
    
    textField1.text = ""
    textField1b.text = ""
    textField2.text = ""
    sliderControl.value = 50
    switchControl.on = true
    textview.text = "your generated story will appear here"
    
    currentNumber = 50
    currentSwitchValue = true
    
    button.setTitle("Generate Story", forState: UIControlState.Normal)
    button.tag = 1
    checkValidationStatus()
    
    /* needed for lab */
    numberLabel.text = "Number (\(currentNumber))"
  }
  
  /* needed for challenge : validation a */
  func showAlert() {
    println("\(__FUNCTION__)")
    
    let alertController = UIAlertController(title: "Missing Data!", message: "Hey, you're missing something!", preferredStyle: .Alert)
    
    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
    alertController.addAction(defaultAction)
    
    presentViewController(alertController, animated: true, completion: nil)
  }
  
  func checkValidationStatus() {
    println("\(__FUNCTION__)")
    
    /* needed for challenge : validation b - must comment out in order for validation a to work */
    ///*
    if (textField1.text.isEmpty || textField1b.text.isEmpty || textField2.text.isEmpty) {
      button.enabled = false
      button.alpha = 0.50
    } else {
      button.enabled = true
      button.alpha = 1.0
    }
    //*/
  }
  
  @IBAction func hideKeyboard(sender: UIButton) {
    println("\(__FUNCTION__)")
    
    textField1.resignFirstResponder()
    textField1b.resignFirstResponder()
    textField2.resignFirstResponder()
  }
  
  /* needed for challenge : validation b
  note: not all delegates are required for this to work */
  func textFieldShouldBeginEditing(textField: UITextField!) -> Bool {
    return true
  }
  
  func textFieldDidBeginEditing(textField: UITextField!) {
    
  }
  
  func textFieldShouldEndEditing(textField: UITextField!) -> Bool {
    return true
  }
  
  func textFieldDidEndEditing(textField: UITextField!) {
    checkValidationStatus()
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    checkValidationStatus()
    return true
  }
  
  func textFieldShouldReturn(textField: UITextField!) -> Bool {
    textField.resignFirstResponder()
    
    return true
  }
  
  func textFieldShouldClear(textField: UITextField!) -> Bool {
    
    return true
  }
}

