//
//  ViewController.swift
//  StoryTime
//
//  Created by Tammy Coron on 11/17/14.
//  Copyright (c) 2014 Tammy Coron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentNumber = 50
    var currentSwitchValue = true
    var storyType = 0
    var monsters = "zombies"
  
    // UNCOMMENT OUT CODE
     var currentStory: Story?
    
    @IBOutlet weak var backgroundImage: UIImageView! // background image
    @IBOutlet weak var segmentedControl: UISegmentedControl! // story selection
    @IBOutlet weak var textField1: UITextField! // name
    @IBOutlet weak var textField2: UITextField! // verb
    @IBOutlet weak var sliderControl: UISlider! // number
    @IBOutlet weak var switchControl: UISwitch! // win or lose
    @IBOutlet weak var textview: UITextView! // generated story
    @IBOutlet weak var button: UIButton! // generate story
    
    /* needed for lab */
    @IBOutlet weak var numberLabel: UILabel! // label for number
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      // UNCOMMENT OUT CODE
        if currentStory != nil {
            var image: UIImage!
            if currentStory?.type == StoryType.zombies {
                image = UIImage(named: "zombies")
            } else if currentStory?.type == StoryType.vampires {
              image = UIImage(named: "vampires")
            } else {
                image = UIImage(named: "aliens")
            }
            backgroundImage.image = image
        }
        
        textview.layer.borderColor = UIColor.darkGrayColor().CGColor
        textview.layer.borderWidth = 1.0
        
        /* needed for lab */
        numberLabel.text = "Number (\(currentNumber))"
        
        /* needed for lab : validation b */
        checkValidationStatus()
    }


  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func hideKeyboard(sender: UIButton) {
        textField1.resignFirstResponder()
        textField2.resignFirstResponder()
    }
    
    @IBAction func segmentedControllerChanged(sender: UISegmentedControl) {
        storyType = sender.selectedSegmentIndex
      
        // UNCOMMENT OUT CODE

        var image : UIImage!
        switch storyType {
        case 0:
            image = UIImage(named:"zombies")
            monsters = "zombies"
        case 1:
            image = UIImage(named:"vampires")
            monsters = "vampires"
        case 2:
            image = UIImage(named: "aliens")
            monsters = "aliens"
        default:
            sender.tag = 0
        }
        resetStory()
        backgroundImage.image = image

    }
    
    @IBAction func sliderMoved(sender: UISlider) {
        currentNumber = lroundf(sender.value)
        
        /* needed for lab */
        numberLabel.text = "Number (\(currentNumber))"
    }
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        if (sender.on) {
            currentSwitchValue = true
        } else {
            currentSwitchValue = false
        }
    }
    
    @IBAction func generateStory(sender: UIButton) {
        
        /* needed for lab : validation a */
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
      
        // UNCOMMENT OUT CODE

        if currentStory != nil {
            currentStory?.name = textField1.text
            currentStory?.verb = textField2.text
            currentStory?.number = Int(sliderControl.value)
            textview.text = currentStory?.generateStory(switchControl.on)
        }

    }
  
  override func viewWillAppear(animated: Bool) {
    
  }
  
    func resetStory() {
        textField1.text = ""
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
    
    /* needed for lab : validation a */
    func showAlert() {
        let alertController = UIAlertController(title: "Missing Data!", message: "Hey, you're missing something!", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func checkValidationStatus() {
        if (textField1.text.isEmpty || textField2.text.isEmpty) {
            button.enabled = false
            button.alpha = 0.50
        } else {
            button.enabled = true
            button.alpha = 1.0
        }
    }
    
    /* needed for lab : validation b
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

