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
    
    //// Color Declarations
    let gridLineColor = UIColor(red: 0.919, green: 0.927, blue: 0.903, alpha: 1.000)
    
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
    
    
    //// topGridLine Drawing
    var topGridLinePath = UIBezierPath()
    topGridLinePath.moveToPoint(CGPointMake(frame.minX + 0.08906 * frame.width, frame.minY + 0.14250 * frame.height))
    topGridLinePath.addCurveToPoint(CGPointMake(frame.minX + 0.89844 * frame.width, frame.minY + 0.14250 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.89219 * frame.width, frame.minY + 0.13750 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.89844 * frame.width, frame.minY + 0.14250 * frame.height))
    gridLineColor.setStroke()
    topGridLinePath.lineWidth = 1
    topGridLinePath.stroke()
    
    
    //// midGridLine Drawing
    var midGridLinePath = UIBezierPath()
    midGridLinePath.moveToPoint(CGPointMake(frame.minX + 0.08906 * frame.width, frame.minY + 0.50250 * frame.height))
    midGridLinePath.addCurveToPoint(CGPointMake(frame.minX + 0.89844 * frame.width, frame.minY + 0.50250 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.89219 * frame.width, frame.minY + 0.49750 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.89844 * frame.width, frame.minY + 0.50250 * frame.height))
    gridLineColor.setStroke()
    midGridLinePath.lineWidth = 1
    CGContextSaveGState(context)
    CGContextSetLineDash(context, 0, [4, 7], 2)
    midGridLinePath.stroke()
    CGContextRestoreGState(context)
    
    
    //// bottomGridLine Drawing
    var bottomGridLinePath = UIBezierPath()
    bottomGridLinePath.moveToPoint(CGPointMake(frame.minX + 0.08906 * frame.width, frame.minY + 0.84250 * frame.height))
    bottomGridLinePath.addCurveToPoint(CGPointMake(frame.minX + 0.89844 * frame.width, frame.minY + 0.84250 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.89219 * frame.width, frame.minY + 0.83750 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.89844 * frame.width, frame.minY + 0.84250 * frame.height))
    gridLineColor.setStroke()
    bottomGridLinePath.lineWidth = 1
    bottomGridLinePath.stroke()
    
    
    //// lineGraphRect Drawing
    let lineGraphRect = CGRectMake(frame.minX + floor(frame.width * 0.09062 + 0.5), frame.minY + floor(frame.height * 0.20000 + 0.5), floor(frame.width * 0.89844) - floor(frame.width * 0.09062 + 0.5) + 0.5, floor(frame.height * 0.78000 + 0.5) - floor(frame.height * 0.20000 + 0.5))
    
    let graphBezier = generateBezierPathForGraph(lineGraphRect.size)
    
    //1
    UIColor.greenColor().set()
    //2
    CGContextSaveGState(context)
    //3
    CGContextTranslateCTM(context, lineGraphRect.origin.x, lineGraphRect.origin.y)
    //4
    graphBezier.stroke()
    //5
    CGContextRestoreGState(context)
  }
  
  func generateBezierPathForGraph(size : CGSize) -> UIBezierPath
  {
    let bezierPath = UIBezierPath()
    let valueDiff = maxValues - minValues
    
    for i in 0..<values.count {
      let number = values[i]
      //1
      let normalizedScale = CGFloat(number - minValues) / CGFloat(valueDiff)
      //2
      let invertedValue = 1.0 - normalizedScale
      //3
      let yPosition = invertedValue * size.height
      //4
      let xPosition = CGFloat(i) * (size.width / CGFloat(values.count - 1))
      
      let point = CGPointMake(xPosition, yPosition)
      
      if i == 0 {
        bezierPath.moveToPoint(point)
      } else {
        bezierPath.addLineToPoint(point)
      }
      
    }
    return bezierPath
  }
}
