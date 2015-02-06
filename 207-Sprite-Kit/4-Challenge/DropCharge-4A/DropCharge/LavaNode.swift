//
//  LavaNode.swift
//  DropCharge
//
//  Created by Main Account on 11/28/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit

class LavaNode: SKNode {

  init(useEmitter: Bool) {
    super.init()
    var lava: SKNode
    if useEmitter {
      lava = SKEmitterNode(fileNamed: "Lava")
    } else {
      lava = SKSpriteNode(color: SKColorWithRGB(255, 134, 16), size:CGSize(width: 320, height: 150))
    }
    addChild(lava)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(dt: NSTimeInterval) {
  
    let lowerLeft = CGPoint(x: 0, y: 0)
    let visibleMinYFg = scene!.convertPoint(lowerLeft, toNode: self.parent!).y
  
    let lavaVelocity = CGPoint(x: 0, y: 120)
    let lavaStep = lavaVelocity * CGFloat(dt)
    var newPosition = position + lavaStep
    
    newPosition.y = max(newPosition.y, visibleMinYFg - 125.0)
    position = newPosition
  
  }

}