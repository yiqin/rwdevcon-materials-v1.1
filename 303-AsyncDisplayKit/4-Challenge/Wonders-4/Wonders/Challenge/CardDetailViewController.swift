//
//  CardDetailViewController.swift
//  Wonders
//
//  Created by Rene Cacheaux on 1/31/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {
  let card: Card
  var nodeInstalled = false
  
  init(card: Card) {
    self.card = card
    super.init(nibName: nil, bundle: nil)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) not supported")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    if !nodeInstalled {
      nodeInstalled = true
      dispatch_async(dispatch_queue_t.backgroundQueue) {
        let node = CardDetailNode(card: self.card)
        node.exitClosure = {
          self.dismissViewControllerAnimated(true, completion: nil)
        }
        node.measure(self.view.frame.size)
        node.frame = CGRect(origin: CGPointZero, size: node.calculatedSize)
        dispatch_async(dispatch_queue_t.mainQueue) {
          self.view.addSubview(node.view)
        }
      }
    }
  }
}
