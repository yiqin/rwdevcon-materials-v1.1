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
    
    // Size and position using manual frames
    indicator.frame.size = CGSize(width: 150, height: 150)
    indicator.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
    
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
