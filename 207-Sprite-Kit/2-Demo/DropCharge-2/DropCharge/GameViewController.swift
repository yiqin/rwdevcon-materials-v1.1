//
//  GameViewController.swift
//  DropCharge
//
//  Created by Main Account on 11/23/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()    
    let scene = GameScene(size:CGSize(width: 320, height: 568))
    let skView = self.view as SKView
    skView.showsFPS = true
    skView.showsNodeCount = true
    skView.showsPhysics = true
    skView.ignoresSiblingOrder = false
    scene.scaleMode = .AspectFill
    skView.presentScene(scene)
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
}
