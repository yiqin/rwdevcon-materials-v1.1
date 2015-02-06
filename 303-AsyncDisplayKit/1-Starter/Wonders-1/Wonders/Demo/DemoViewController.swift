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
    
    
  }
  
  func addDisplayLink() {
    displayLink = CADisplayLink(target: self, selector: "displayNextFrameNumber")
    displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: kCFRunLoopCommonModes)
  }
  
  func displayNextFrameNumber() {
    frameLabel.text = "\(frameCount++)"
  }
}
