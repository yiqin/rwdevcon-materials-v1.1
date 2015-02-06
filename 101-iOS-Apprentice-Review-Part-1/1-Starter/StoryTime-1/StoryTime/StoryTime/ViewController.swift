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
  
  // setup variables
  
  // setup IBOutlets
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func segmentedControllerChanged(sender: UISegmentedControl) {
    println("\(__FUNCTION__)")
    
  }
  
  @IBAction func sliderMoved(sender: UISlider) {
    println("\(__FUNCTION__)")
    
  }
  
  @IBAction func switchValueChanged(sender: UISwitch) {
    println("\(__FUNCTION__)")
    
  }
  
  @IBAction func generateStory(sender: UIButton) {
    println("\(__FUNCTION__)")
    
  }
  
  func populateStory() {
    println("\(__FUNCTION__)")
    
    /*
    if (currentSwitchValue) {
    textview.text = "\(textField1.text) entered the room and saw \(currentNumber) \(monsters)! \(textField1.text) \(textField2.text) down the hall. Sadly, \(textField1.text) was killed by all of the \(monsters)! \n\nPoor \(textField1.text). \n\nBetter luck next time!"
    } else {
    textview.text = "\(textField1.text) entered the room and saw \(currentNumber) \(monsters)! \(textField1.text) \(textField2.text) down the hall. Without missing a beat, \(textField1.text) killed all of the \(monsters)! \n\nFantastic! \n\nOur hero will live to fight another day."
    }
    */
  }
  
  func resetStory() {
    println("\(__FUNCTION__)")
    
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

