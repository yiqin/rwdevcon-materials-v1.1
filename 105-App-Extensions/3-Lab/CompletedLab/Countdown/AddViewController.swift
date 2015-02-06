/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import CountdownKit

private let dateFormatter: NSDateFormatter = {
  let formatter = NSDateFormatter()
  formatter.dateStyle = NSDateFormatterStyle.MediumStyle
  return formatter
}()

protocol AddViewDelegate {
  func addViewDidSave()
}

class AddViewController: UIViewController {

  var delegate: AddViewDelegate?
  private var selectedImage: UIImage?
  
  @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var dateTextField: UITextField!
  @IBOutlet weak var imageView: UIImageView!
  
  private let datePicker: UIDatePicker = {
    let calendar = NSCalendar.autoupdatingCurrentCalendar()
    let components = calendar.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate: NSDate())
    let picker = UIDatePicker()
    picker.date = calendar.dateFromComponents(components) ?? NSDate()
    picker.datePickerMode = .Date
    return picker
  }()
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dateTextField.text = dateFormatter.stringFromDate(NSDate())
    dateTextField.inputView = datePicker
    datePicker.addTarget(self, action: "datePickerValueChanged:", forControlEvents: .ValueChanged)
  }
  
  @IBAction func chooseImage(sender: AnyObject) {
    view.endEditing(true)
    let picker = UIImagePickerController()
    picker.sourceType = .SavedPhotosAlbum
    picker.delegate = self
    presentViewController(picker, animated: true, completion: nil)
  }
  
  @IBAction func save(sender: AnyObject) {
    navigationController?.popToRootViewControllerAnimated(true)
    let targetDay = CoreDataController.sharedInstance.newTargetDay()
    targetDay.name = nameTextField.text
    targetDay.date = datePicker.date
    if let image = selectedImage {
      targetDay.image = image
    } else {
      targetDay.image = UIImage.randomColorImage()
    }
    delegate?.addViewDidSave()
  }
  
  func datePickerValueChanged(picker: UIDatePicker) {
    dateTextField.text = dateFormatter.stringFromDate(datePicker.date)
  }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    let selectedImage = info[UIImagePickerControllerOriginalImage] as UIImage
    dismissViewControllerAnimated(true, completion: nil)
    self.selectedImage = selectedImage
    imageView.image = selectedImage
    
  }
}
