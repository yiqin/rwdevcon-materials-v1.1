//
//  GridViewCocoa.swift
//  Life
//
//  Created by Alexis Gallagher on 2014-11-24.
//  Copyright (c) 2014 AlexisGallagher. All rights reserved.
//

import UIKit

// for illustration, a version of GridView using Cocoa collections instead of Swift collections, and an NSDictionary instead of the custom model class Cell

private let kGridSquareSize : CGFloat = 25
private let kGridSquareCount : Int = 1000
private let GridOriginX : CGFloat = 0
private let GridOriginY : CGFloat = 0

class GridViewCocoa : UIView
{
  var activeCoords : NSSet = NSSet()
  
  override init(frame: CGRect) {
    super.init(frame:frame)
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("handleTap:")))
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("handleTap:")))
  }
  
  func flipCellAtCoords(coords:NSDictionary) {
    var x : NSMutableArray = (self.activeCoords.allObjects as NSArray).mutableCopy() as NSMutableArray;
    if self.activeCoords.containsObject(coords)
    {
      x.removeObjectsInArray([coords])
    }
    else
    {
      x.addObject(coords)
    }
    self.activeCoords = NSSet(array: x)
    self.setNeedsDisplay()
  }
  
  /// De/selects a grid cell
  func handleTap(gr:UITapGestureRecognizer) {
    let touchLocation : CGPoint = gr.locationInView(self)
    let coords : NSDictionary = self.coordsForTouchAt(touchLocation)
    self.flipCellAtCoords(coords)
  }
  
  func coordsForTouchAt(point:CGPoint) -> NSDictionary
  {
    let xCoords : Int = Int(point.x / kGridSquareSize)
    let yCoords : Int = Int(point.y / kGridSquareSize)
    return ["x":xCoords,"y":yCoords] as NSDictionary
  }
  
  func drawShapeAtGridCoords(coords:NSDictionary)
  {
    let diameter = 0.75 * kGridSquareSize
    let x : Int = coords["x"]!.integerValue
    let y : Int = coords["y"]!.integerValue
    
    let circleGridOrigin : CGPoint = CGPointMake(CGFloat(x) * kGridSquareSize, CGFloat(y) * kGridSquareSize)
    let circleRectOrigin = CGPointMake(circleGridOrigin.x + (kGridSquareSize - diameter)/2.0 , circleGridOrigin.y + (kGridSquareSize - diameter)/2.0)
    let circleRect = CGRect(origin: circleRectOrigin, size: CGSize(width: diameter, height: diameter))
    let shapePath = UIBezierPath(ovalInRect: circleRect)
    UIColor.redColor().setStroke()
    UIColor.redColor().setFill()
    shapePath.stroke()
    shapePath.fill()
  }
  
  func drawGridLines() {
    let path = UIBezierPath()
    path.lineWidth = 1
    
    let limit : CGFloat = CGFloat(CGFloat(kGridSquareCount) * kGridSquareSize)
    
    for var y = GridOriginY; y < limit; y = y + kGridSquareSize {
      let minX = GridOriginX
      let maxX = kGridSquareSize * CGFloat(kGridSquareCount)
      path.moveToPoint(CGPoint(x: minX, y: y))
      path.addLineToPoint(CGPoint(x:maxX,y:y))
    }
    
    for var x = GridOriginX; x < (CGFloat(kGridSquareCount) * kGridSquareSize); x = x + kGridSquareSize {
      let minY = GridOriginY
      let maxY = kGridSquareSize * CGFloat(kGridSquareCount)
      path.moveToPoint(CGPoint(x: x, y: minY))
      path.addLineToPoint(CGPoint(x:x,y:maxY))
    }
    
    UIColor.blackColor().setStroke()
    path.stroke()
  }
  
  override func drawRect(rect: CGRect) {
    self.drawGridLines()
    self.activeCoords.enumerateObjectsUsingBlock { (obj, p) -> Void in
      if let coords = obj as? NSDictionary {
        self.drawShapeAtGridCoords(coords)
      }
    }
  }
}
