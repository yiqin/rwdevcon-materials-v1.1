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

import Foundation
import CoreData
import UIKit

private let _calendar = NSCalendar.autoupdatingCurrentCalendar()

@objc(TargetDay)
public class TargetDay: NSManagedObject {
  
  @NSManaged public var date: NSDate
  @NSManaged public var imageData: NSData
  @NSManaged public var reducedImageData: NSData
  @NSManaged public var name: String
  
}

public extension TargetDay {
  public var daysUntil: Int {
    let todayComponents = _calendar.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate: NSDate())
    let todayMidnight = _calendar.dateFromComponents(todayComponents) ?? NSDate()
    
    
    let components = _calendar.components(NSCalendarUnit.DayCalendarUnit, fromDate: todayMidnight, toDate: date, options: nil)
    return components.day
  }
  
  public var image: UIImage {
    get {
      if let image = UIImage(data: imageData) {
        return image
      } else {
        return UIImage.randomColorImage()
      }
    }
    set {
      imageData = UIImageJPEGRepresentation(newValue, 0.8)
      reducedImageData = reduceImage(newValue)
    }
  }
  
  public var reducedImage: UIImage {
    get {
      if let image = UIImage(data: reducedImageData) {
        return image
      } else {
        return UIImage.randomColorImage()
      }
    }
  }
  
  private func reduceImage(image: UIImage) -> NSData {
    let newWidth: CGFloat = 512
    let widthReductionRatio = newWidth / image.size.width
    let newSizeRect = CGRect(x: 0, y: 0, width: newWidth, height: widthReductionRatio * image.size.height)
    
    UIGraphicsBeginImageContextWithOptions(newSizeRect.size, false, 0.0);
    image.drawInRect(newSizeRect)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    let newImageData = UIImageJPEGRepresentation(newImage, 0.5)
    UIGraphicsEndImageContext()
    return newImageData
  }
}
