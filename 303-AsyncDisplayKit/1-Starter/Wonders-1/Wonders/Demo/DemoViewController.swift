//
//  DemoViewController.swift
//  Wonders
//
//  Created by Rene Cacheaux on 1/28/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {
  @IBOutlet weak var frameLabel: UILabel!
  var displayLink: CADisplayLink!
  var frameCount = 0
  let cards = allCards
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let card = cards[0]
    
    
    // We put a lot of staff in CardNode.
    dispatch_async(dispatch_queue_t.backgroundQueue){
        let node = CardNode(card: card)
        node.measure(UIScreen.mainScreen().bounds.size)
        let origin = UIScreen.mainScreen().bounds.originForCenteredRectWithSize(node.calculatedSize)
        node.frame = CGRect(origin: origin, size: node.calculatedSize)
        
        dispatch_async(dispatch_queue_t.mainQueue){
            self.view.addSubview(node.view)
        }
        
    }
    
    
    
  }
  
  func addDisplayLink() {
    displayLink = CADisplayLink(target: self, selector: "displayNextFrameNumber")
    displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: kCFRunLoopCommonModes)
  }
  
  func displayNextFrameNumber() {
    frameLabel.text = "\(frameCount++)"
  }
}
