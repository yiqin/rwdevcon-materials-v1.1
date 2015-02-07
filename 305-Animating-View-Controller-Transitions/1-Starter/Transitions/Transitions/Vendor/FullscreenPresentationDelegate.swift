//
//  FullscreenPresentationDelegate.swift
//  Transitions
//
//  Created by Yi Qin on 2/7/15.
//  Copyright (c) 2015 Ryan Nystrom. All rights reserved.
//

import UIKit

class FullscreenPresentationDelegate: NSObject, UIViewControllerAnimatedTransitioning {
  
  

  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return FullscreenDimissAnimator()
  }
  
  func animationControllerForPresentationController().......
  

}
