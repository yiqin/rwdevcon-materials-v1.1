//
//  FullscreenPresentationDelegate.swift
//  Transitions
//
//  Created by Ryan Nystrom on 11/2/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation
import UIKit

class FullscreenPresentationDelegate: NSObject, UIViewControllerTransitioningDelegate {

  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    println("dismissed")
    return FullscreenDismissAnimator()
  }

  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    println("presenting")
    return FullscreenPresentationAnimator()
  }

}