// Playground - noun: a place where people can play

import UIKit

class LineGraphView : UIView {
  override func drawRect(rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    
    let insetRect = CGRectInset(rect, 10, 10)
    let rectanglePath = UIBezierPath(roundedRect: insetRect, cornerRadius: 11)
    
    let backGradientStart = UIColor.lightGrayColor()
    let backGradientEnd = UIColor.whiteColor()
    
    let backGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [backGradientEnd.CGColor, backGradientStart.CGColor], [0, 1])
    
    CGContextSaveGState(context)
    rectanglePath.addClip()
    
    CGContextDrawLinearGradient(context, backGradient,
      CGPoint(x: CGRectGetMidX(insetRect), y: CGRectGetMinY(insetRect)),
      CGPoint(x: CGRectGetMidX(insetRect), y: CGRectGetMaxY(insetRect)),
      0)
    
    
  }
}

let lineGraphView = LineGraphView(frame: CGRect(x: 0, y: 0, width: 320, height: 200))
