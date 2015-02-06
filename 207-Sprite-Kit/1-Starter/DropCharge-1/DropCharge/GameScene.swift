//
//  GameScene.swift
//  DropCharge
//
//  Created by Main Account on 11/23/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import SpriteKit
import CoreMotion
import AVFoundation

class GameScene: SKScene {

  // MARK: Properties
  var lastUpdateTime: NSTimeInterval = 0
  var dt: NSTimeInterval = 0
  let motionManager = CMMotionManager()
  var xAcceleration = CGFloat(0)
  var gameState = GameState.WaitingForTap
  let worldNode = SKNode()
  var bgNode = BackgroundNode()
  var mgNode = MidgroundNode()
  var fgNode = SKNode()
  var level = LevelNode()
  
  // MARK: Init
  override func didMoveToView(view: SKView) {
    setupLevel()
    setupNodes()
    setupPlayer()
    setupPhysics()
    setupMusic()
    setupCoreMotion()
  }

  func setupLevel() {
  }

  func setupNodes() {
  
    addChild(worldNode)
    worldNode.addChild(bgNode)
    worldNode.addChild(mgNode)
    worldNode.addChild(fgNode)
    
    level.zPosition = ForegroundZ.Level.rawValue
    fgNode.addChild(level)
  
  }

  func setupPlayer() {
  }

  func setupPhysics() {
  }
  
  func setupMusic() {
  }
  
  func setupCoreMotion() {
    motionManager.accelerometerUpdateInterval = 0.2
    motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {
      (accelerometerData: CMAccelerometerData!, error: NSError!) in
      let acceleration = accelerometerData.acceleration
      self.xAcceleration = (CGFloat(acceleration.x) * 0.75) + (self.xAcceleration * 0.25)
    })
  }
  
  // MARK: Game State
  
  func switchToWaitingForBomb() {
  
    // Switch game state
    gameState = .WaitingForBomb
    
    // Scale out title
    
    // Add bomb
    
    // Bounce bomb
    
    // Switch to playing state
  
  }
  
  func switchToPlaying() {
  
    // Switch game state
    gameState = .Playing
    
    // Stop bomb
    
    // Start player movement
  
  }
  
  // MARK: Touch Handling
  func handlePlayingTouches(touches: NSSet) {
    if let touch = touches.anyObject() as? UITouch {
      // TODO
    }
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    switch gameState {
      case .WaitingForTap:
        switchToWaitingForBomb()
      case .Playing:
        handlePlayingTouches(touches)
      default:
        break;
    }
  }
  
  override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
    switch gameState {
      case .Playing:
        handlePlayingTouches(touches)
      default:
        break;
    }
  }
  
  // MARK: Update
  
  override func update(currentTime: NSTimeInterval) {
    if lastUpdateTime > 0 {
      dt = currentTime - lastUpdateTime
    } else {
      dt = 0
    }
    lastUpdateTime = currentTime
    
    if gameState == .Playing {
      updateCamera()
      updatePlayer()
      bgNode.update(lastUpdateTime)
      mgNode.update(lastUpdateTime)
      level.update()
    }
  }
  
  func updateCamera() {
  
    /*
    let target = player.position
    var targetPosition = CGPoint(x: worldNode.position.x, y: -(target.y - size.height * 0.4))
    var newPosition = targetPosition
    
    self.fgNode.position = newPosition
    self.mgNode.position = newPosition
    self.bgNode.position = newPosition
    */
  
  }
  
  func updatePlayer() {
    
    // Set velocity based on core motion
    // player.physicsBody?.velocity.dx = xAcceleration * 400.0
  
    // Wrap player around edges of screen
    /*
    if player.position.x < -player.size.width/2 {
      player.position.x = size.width + player.size.width/2
    }
    else if player.position.x > size.width + player.size.width/2 {
      player.position.x = -player.size.width/2
    }
    */
  
  }
    
  // MARK: Contacts
  
  func didBeginContact(contact: SKPhysicsContact) {
 
    let other = contact.bodyA.categoryBitMask == PhysicsCategory.Player ? contact.bodyB : contact.bodyA
    
    switch other.categoryBitMask {
      case PhysicsCategory.CoinNormal:
        if let coin = other.node as? SKSpriteNode {
          // TODO
        }
      case PhysicsCategory.CoinSpecial:
        if let coin = other.node as? SKSpriteNode {
          // TODO
        }
      case PhysicsCategory.PlatformNormal:
        if let platform = other.node as? SKSpriteNode {
          // TODO
        }
      case PhysicsCategory.PlatformBreakable:
        if let platform = other.node as? SKSpriteNode {
          // TODO
        }
      default:
      break;
    }
 
  }
  
  // MARK: Helpers
  func setPlayerVelocity(amount:CGFloat) {
  }
  
  func jumpPlayer() {
    setPlayerVelocity(650)
  }
  
  func boostPlayer() {
    setPlayerVelocity(1000)
  }
  
  func superBoostPlayer() {
    setPlayerVelocity(1500)
  }
  
}