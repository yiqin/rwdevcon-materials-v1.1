//
//  ExplosionManager.swift
//  DropCharge
//
//  Created by Main Account on 11/28/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit

class ExplosionManager {

  let soundManager: SoundManager
  let screenShakeByAmt: (CGFloat) -> ()
  let parentNode: SKNode
  var timeSinceLastExplosion: CGFloat = 0
  var timeForNextExplosion: CGFloat = 0

  init(soundManager: SoundManager, screenShakeByAmt: (CGFloat) -> (), parentNode: SKNode) {
    self.soundManager = soundManager
    self.screenShakeByAmt = screenShakeByAmt
    self.parentNode = parentNode
  }

  func createRandomExplosionAtPos(pos: CGPoint) {
    
    let randomNum = Int.random(soundManager.soundExplosions.count)
    soundManager.playSoundExplosion(randomNum)
    
    let explosion = SKEmitterNode(fileNamed: "ColoredExplosion")
    explosion.position = parentNode.scene!.convertPoint(pos, toNode:parentNode)
    explosion.particleScale = ((CGFloat(randomNum) + 1) / 2)
    parentNode.addChild(explosion)
    
    explosion.runAction(SKAction.removeFromParentAfterDelay(1.0))
    
    if (Int.random(soundManager.soundExplosions.count) == 0) {
      screenShakeByAmt(4.0 * CGFloat(randomNum))
    }
    
  }
  
  func update(dt: NSTimeInterval) {    
    timeSinceLastExplosion += CGFloat(dt)
    if timeSinceLastExplosion > timeForNextExplosion {
    
      timeForNextExplosion = CGFloat.random(min: 0.1, max: 0.5)
      timeSinceLastExplosion = 0
      
      let sceneSize = parentNode.scene!.size
      let screenPos = CGPoint(x: CGFloat.random(min: 0, max: sceneSize.width), y: CGFloat.random(min: sceneSize.height * -0.1, max: sceneSize.height * 1.1))
      createRandomExplosionAtPos(screenPos)
    
    }
  }

}