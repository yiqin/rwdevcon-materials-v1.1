//
//  UITableView+PathFinder.swift
//  Seuss
//
//  Created by Richard Turton on 20/11/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

extension UITableView {
  func indexPathForView (view : UIView) -> NSIndexPath? {
    let location = view.convertPoint(CGPointZero, toView:self)
    return indexPathForRowAtPoint(location)
  }
}
