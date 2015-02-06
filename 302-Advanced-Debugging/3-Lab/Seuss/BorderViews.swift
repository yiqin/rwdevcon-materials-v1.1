//
//  BorderViews.swift
//  Seuss
//
//  Created by Richard Turton on 04/01/2015.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

private let colorBarTag = 98
private let backgroundTag = 99

extension UIView {
    
    @IBInspectable var topBorder : UIColor {
        set {
            if self.backgroundBorder == nil {
                let backgroundBorder = UIView(frame: self.bounds)
                backgroundBorder.autoresizingMask = .FlexibleHeight | .FlexibleWidth
                backgroundBorder.tag = backgroundTag
                backgroundBorder.backgroundColor = UIColor.whiteColor()
                backgroundBorder.layer.borderWidth = 1.0;
                backgroundBorder.layer.borderColor = UIColor.lightGrayColor().CGColor
                self.insertSubview(backgroundBorder, atIndex:0)
            }
            if let colorBar = self.colorBar {
                colorBar.backgroundColor = newValue
            } else {
                let colorBar = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: 4.0))
                colorBar.autoresizingMask = .FlexibleBottomMargin | .FlexibleWidth
                colorBar.tag = colorBarTag
                colorBar.backgroundColor = newValue
                self.insertSubview(colorBar, aboveSubview: self.backgroundBorder!)
            }
        }
        get { return UIColor() }
    }
    
    private var backgroundBorder : UIView? {
        get {
            return self.viewWithTag(backgroundTag)
        }
    }
    
    private var colorBar : UIView? {
        get {
            return self.viewWithTag(colorBarTag)
        }
    }
}
