//
//  FullscreenPresentationAnimator.swift
//  Transitions
//
//  Created by Yi Qin on 2/7/15.
//  Copyright (c) 2015 Ryan Nystrom. All rights reserved.
//

import UIKit

class FullscreenPresentationAnimator: NSObject,UIViewControllerAnimatedTransitioning {

  
  
  func transitionDuration(transitionContext:UIViewCOntrollerContextTransition)->NSTimeInternval{
    return 0.4
  }
  
  func animateTransition(transitionContext:UIViewControllerAnimatedTransitioning)
  {
    let to = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)! as PhotoDetailController
    
    let from = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)! as PhotosController
    
    let contrainer = transitionContext.contrainerView()
    let duration = transitionDuration(transitionContext)
    
    // If this line is not called. nothing will happen.
    container.addSubview(to.view)
    
    
    to.view.transform = CGAffineTransformMakeScale(0.1,0.1)
    
    // Before it is just sitting there
    
    UIView.animateWithDuration(duration, animations: {()-> Void in
      to.view.transform = CGAffineTransformIdentity
      
      
      }) { finished in
        
        // Use to let you know if it's canceled
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        
        
    }
    
    
    
  }
  
  
  
  
  
}
