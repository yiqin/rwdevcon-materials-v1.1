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
}
