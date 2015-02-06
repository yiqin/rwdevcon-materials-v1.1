//
//  ActivityIndicator.swift
//  Seuss
//
//  Created by Richard Turton on 13/11/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func displayActivity(seconds: Int, completion:(()->Void)?) {
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    indicator.layer.cornerRadius = 10.0
    indicator.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
    view.addSubview(indicator)
    
    // Size and position using autolayout
    indicator.setTranslatesAutoresizingMaskIntoConstraints(false)
    let views = ["indicator":indicator]
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[indicator(150)]", options: nil, metrics: nil, views: views))
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[indicator(150)]", options: nil, metrics: nil, views: views))
    view.addConstraint(NSLayoutConstraint(item: indicator, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: indicator, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0))
    
    
    view.tintAdjustmentMode = .Dimmed
    
    indicator.startAnimating()
    UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    
    let after = Int64(seconds) * Int64(NSEC_PER_SEC)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, after), dispatch_get_main_queue()){
      indicator.removeFromSuperview()
      UIApplication.sharedApplication().endIgnoringInteractionEvents()
      self.view.tintAdjustmentMode = .Normal
      if let completion = completion {
        completion()
      }
    }
  }
}
