//
//  ViewController.swift
//  StoryTime
//
//  Created by Tammy Coron on 11/17/14.
//  Copyright (c) 2014 Tammy Coron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: Properties
  var currentNumber = 50
  var currentSwitchValue = true
  var storyType = 0
  var monsters = "zombies"
  
  @IBOutlet weak var backgroundImage: UIImageView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var textField1: UITextField!
  @IBOutlet weak var textField2: UITextField!
  @IBOutlet weak var sliderControl: UISlider!
  @IBOutlet weak var switchControl: UISwitch!
  @IBOutlet weak var textview: UITextView!
  @IBOutlet weak var button: UIButton!
  
  @IBOutlet weak var numberLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textview.layer.borderColor = UIColor.darkGrayColor().CGColor
    textview.layer.borderWidth = 1.0
    
    numberLabel.text = "Number (\(currentNumber))"
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func segmentedControllerChanged(sender: UISegmentedControl) {
    println("\(__FUNCTION__)")
    
    storyType = sender.selectedSegmentIndex
    
    var image : UIImage!
    
    switch storyType {
    case 0:
      image = UIImage(named:"zombies")
      monsters = "zombies"
    case 1:
      image = UIImage(named:"vampires")
      monsters = "vampires"
    case 2: // optional lab
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
      textview.text = "\(textField1.text) entered the room and saw \(currentNumber) \(monsters)! \(textField1.text) \(textField2.text) down the hall. Sadly, \(textField1.text) was killed by all of the \(monsters)! \n\nPoor \(textField1.text). \n\nBetter luck next time!"
    } else {
      textview.text = "\(textField1.text) entered the room and saw \(currentNumber) \(monsters)! \(textField1.text) \(textField2.text) down the hall. Without missing a beat, \(textField1.text) killed all of the \(monsters)! \n\nFantastic! \n\nOur hero will live to fight another day."
    }
  }
  
  func resetStory() {
    println("\(__FUNCTION__)")
    
    textField1.text = ""
    textField2.text = ""
    sliderControl.value = 50
    switchControl.on = true
    textview.text = "your generated story will appear here"
    
    currentNumber = 50
    currentSwitchValue = true
    
    button.setTitle("Generate Story", forState: UIControlState.Normal)
    button.tag = 1
    
    numberLabel.text = "Number (\(currentNumber))"
  }
  
  func showAlert() {
    println("\(__FUNCTION__)")
    
  }
  
  func checkValidationStatus() {
    println("\(__FUNCTION__)")
    
  }
  
  // MARK: Keyboard
  @IBAction func hideKeyboard(sender: UIButton) {
    println("\(__FUNCTION__)")
    
    textField1.resignFirstResponder()
    textField2.resignFirstResponder()
  }
  
  // MARK: UITextField Delegate Methods
  func textFieldShouldBeginEditing(textField: UITextField!) -> Bool {
    return true
  }
  
  func textFieldDidBeginEditing(textField: UITextField!) {
    
  }
  
  func textFieldShouldEndEditing(textField: UITextField!) -> Bool {
    return true
  }
  
  func textFieldDidEndEditing(textField: UITextField!) {
    
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
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

