//
//  GridView.swift
//  Life
//
//  Created by Alexis Gallagher on 2014-11-23.
//  Copyright (c) 2014 AlexisGallagher. All rights reserved.
//

import UIKit

/*

Displays an array of Cells as circles on a grid.

The top left corner of Cell(x:0,y:0) is always at CGPoint(x:,y:0) within the view's local
coordinate system. If you wish to render areas of "grid space" that do not start at Cell(x:0,y:0),
then just reset bounds.origin to a value which is not CGPoint(x:0,y:0).

*/

// size in points of a single grid sqaure
private let kGridSquareSize : CGFloat = 44

class GridView: UIScrollView , UIScrollViewDelegate
{
  var activeCoords : [Cell] = Array<Cell>()
  
  override init(frame: CGRect) {
    super.init(frame:frame)
    self.setup()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
  }
  
  private func setup() {
    self.contentSize = CGSize(width: 1000, height: 1000)
    self.delegate = self
    
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("handleTap:")))
  }
  
  // MARK: UIScrollViewDelegate
  func scrollViewDidScroll(scrollView: UIScrollView) {
    self.setNeedsDisplay()
  }

  
  func toggleActivationOfCell(cell:Cell)
  {
    /*
    (Because Swift arrays are value types, this style of doing the mutation
    on a copied array and then assigning the copied array back to the
    member variables is likely to be less efficient than simply mutating the
    member variable directly if you're handling structs and if the collection
    type does not optimize cleverly. But it is clear.)
    */
    var updatedCells = self.activeCoords
    if let index = find(updatedCells, cell)
    {
      updatedCells.removeAtIndex(index)
    }
    else
    {
      updatedCells.append(cell)
    }
    self.activeCoords = updatedCells
    self.setNeedsDisplay()
  }
  
  /// De/selects a grid cell
  func handleTap(gr:UITapGestureRecognizer)
  {
    func cellForTouch(AtPoint point:CGPoint) -> Cell {
      return Cell(
        x:Int(floor(point.x  / kGridSquareSize)),
        y:Int(floor(point.y  / kGridSquareSize))
      )
    }
    
    let touchLocation = gr.locationInView(self)
    let cell = cellForTouch(AtPoint: touchLocation)
    self.toggleActivationOfCell(cell)
  }
  
  override func drawRect(rect: CGRect) {
    DrawGridAndCells(self.activeCoords, inRect:rect)
  }
}

//
// MARK: - drawing code
//

/// Draws grid lines and active cells into the implicit graphics context
func DrawGridAndCells(cells:[Cell], inRect rect:CGRect) -> Void {
  DrawGridLines(withSquareSize:kGridSquareSize, inRect:rect)
  cells.map( { DrawCircleAtCell($0, withSquareSize:kGridSquareSize) })
}

/// Draw Circle at cell into the implicit graphics context
func DrawCircleAtCell(cell:Cell, withSquareSize squareSize:CGFloat)
{
  let diameter = 0.75 * squareSize
  let circleGridOrigin = CGPointMake(CGFloat(cell.x) * squareSize, CGFloat(cell.y) * squareSize)
  let circleRectOrigin = CGPointMake(circleGridOrigin.x + (squareSize - diameter)/2.0 , circleGridOrigin.y + (squareSize - diameter)/2.0)
  let circleRect = CGRect(origin: circleRectOrigin, size: CGSize(width: diameter, height: diameter))
  let shapePath = UIBezierPath(ovalInRect: circleRect)
  UIColor.redColor().setStroke()
  UIColor.redColor().setFill()
  shapePath.stroke()
  shapePath.fill()
}

/// Draws a square grid with an origin at CGPoint(x:0,y:0)
func DrawGridLines(withSquareSize squareSize:CGFloat, inRect rect:CGRect) {
  let path = UIBezierPath()
  path.lineWidth = 0.5

  let xRange = smallestInterval(divisibleByFactor: squareSize, containingInterval: (min: CGRectGetMinX(rect), max: CGRectGetMaxX(rect)))
  let yRange = smallestInterval(divisibleByFactor: squareSize, containingInterval: (min: CGRectGetMinY(rect), max: CGRectGetMaxY(rect)))

  for var y = yRange.min; y < yRange.max; y = y + squareSize {
    path.moveToPoint(   CGPoint(x:xRange.min, y:y))
    path.addLineToPoint(CGPoint(x:xRange.max, y:y))
  }

  for var x = xRange.min; x < xRange.max; x = x + squareSize {
    path.moveToPoint(   CGPoint(x:x, y:yRange.min))
    path.addLineToPoint(CGPoint(x:x, y:yRange.max))
  }
  
  UIColor.blackColor().setStroke()
  path.stroke()
}

/*
Given the INTERVAL (a,b), returns a new interval (a',b') such that:

- the interval (a',b') contains the interval (a,b)
- a' and b' are divisible by FACTOR

*/
func smallestInterval(divisibleByFactor factor:CGFloat, containingInterval interval:(min:CGFloat, max: CGFloat)) -> (min:CGFloat,max:CGFloat)
{
  let minFloored = factor * floor( interval.min / factor )
  let maxCeiled  = factor *  ceil( interval.max / factor )
  return (minFloored,maxCeiled)
}

