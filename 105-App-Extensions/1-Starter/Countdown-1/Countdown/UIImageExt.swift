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

public extension UIImage {
  
  public class func randomColorImage() -> UIImage {
    let goldenRatioConjugate = 0.618033988749895
    var h = Double(arc4random_uniform(100))/100.0
    h += goldenRatioConjugate
    h %= 1
    
    let color = UIColor(hue: CGFloat(h), saturation: 0.5, brightness: 0.95, alpha: 1.0)
    return image(color)
  }
  
  public class func image(color: UIColor) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return image
  }
  
  public var averageColor: UIColor {
    
    var rgba = UnsafeMutablePointer<CUnsignedChar>.alloc(4)
    let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(CGImageAlphaInfo.PremultipliedLast.rawValue) | CGBitmapInfo(CGBitmapInfo.ByteOrder32Big.rawValue)
    let context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, bitmapInfo)
    
    CGContextDrawImage(context, CGRect(x: 0, y: 0, width: 1, height: 1), self.CGImage)
    
    if rgba[3] > 0 {
      let alpha = CGFloat(rgba[3])/255.0
      let multiplier = alpha/255.0
      let red = CGFloat(rgba[0]) * multiplier
      let green = CGFloat(rgba[1]) * multiplier
      let blue = CGFloat(rgba[2]) * multiplier
      return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    } else {
      let red = CGFloat(rgba[0]) / 255.0
      let green = CGFloat(rgba[1]) / 255.0
      let blue = CGFloat(rgba[2]) / 255.0
      let alpha = CGFloat(rgba[3]) / 255.0
      return UIColor(red: red, green: green, blue: blue, alpha:alpha)
    }
  }
  
  public func averageColorImage() -> UIImage {
    return UIImage.image(self.averageColor)
  }
}