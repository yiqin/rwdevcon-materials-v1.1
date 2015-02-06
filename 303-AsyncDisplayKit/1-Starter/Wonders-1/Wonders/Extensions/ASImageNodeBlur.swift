//
//  ASImageNodeBlur.swift
//  Wonders
//
//  Created by Rene Cacheaux on 1/28/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

extension ASImageNode {
  var blurClosure: (UIImage!) -> (UIImage!) {
    return {[weak self] input in
      if input == nil {
        return input
      }
      let didCancelBlur: () -> Bool = {
        if let strongSelf = self {
          if NSThread.isMainThread() {
            return strongSelf.displaySuspended
          } else {
            var isDisplaySuspended = true
            dispatch_sync(dispatch_get_main_queue()) {
              isDisplaySuspended = strongSelf.displaySuspended
            }
            return isDisplaySuspended
          }
        }
        return false
      }
      if let blurredImage = input.applyBlurWithRadius(30, tintColor: UIColor(white: 0.5, alpha: 0.3),
        saturationDeltaFactor: 1.8, maskImage: nil,
        didCancel:didCancelBlur) {
          return blurredImage
      } else {
        return input
      }
    }
  }
}
