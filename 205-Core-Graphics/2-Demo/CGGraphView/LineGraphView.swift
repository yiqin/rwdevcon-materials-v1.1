//
//  LineGraphView.swift
//  CGGraphView
//
//  Created by Jake Gundersen on 11/27/14.
//  Copyright (c) 2014 RazeWare, LLC. All rights reserved.
//
import Foundation
import UIKit

@objc(LineGraphView) class LineGraphView : UIView {
  var values : [Int]
  var minValues : Int
  var maxValues : Int
  
  override init(frame: CGRect) {
    let file = NSBundle.mainBundle().pathForResource("Steps", ofType: "plist")
    values = NSArray(contentsOfFile: file!) as [Int]
    minValues = values.reduce(Int.max, { min($0, $1) })
    maxValues = values.reduce(Int.min, { max($0, $1) })
    
    super.init(frame: frame)
  }
  
  required init(coder aDecoder: NSCoder) {
    let file = NSBundle.mainBundle().pathForResource("Steps", ofType: "plist")
    values = NSArray(contentsOfFile: file!) as [Int]
    
    minValues = values.reduce(Int.max, { min($0, $1) })
    maxValues = values.reduce(Int.min, { max($0, $1) })
    super.init(coder: aDecoder)
  }
  
  override func drawRect(rect: CGRect) {
   drawGraph(frame: rect)
  }
  
  func drawGraph(#frame: CGRect) {
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()
    
    
    //// Gradient Declarations
    let backGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [UIColor.lightGrayColor().CGColor, UIColor.darkGrayColor().CGColor], [0, 1])
    
    //// Rectangle Drawing
    let rectangleRect = CGRectMake(frame.minX + floor(frame.width * 0.03125 + 0.5), frame.minY + floor(frame.height * 0.05000 + 0.5), floor(frame.width * 0.96875 + 0.5) - floor(frame.width * 0.03125 + 0.5), floor(frame.height * 0.95000 + 0.5) - floor(frame.height * 0.05000 + 0.5))
    let rectanglePath = UIBezierPath(roundedRect: rectangleRect, cornerRadius: 11)
    CGContextSaveGState(context)
    rectanglePath.addClip()
    CGContextDrawLinearGradient(context, backGradient,
      CGPointMake(rectangleRect.midX, rectangleRect.minY),
      CGPointMake(rectangleRect.midX, rectangleRect.maxY),
      0)
    CGContextRestoreGState(context)
  }


}
