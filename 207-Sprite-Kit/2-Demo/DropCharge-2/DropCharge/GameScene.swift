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

class GameScene: SKScene, SKPhysicsContactDelegate {

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
  var title: SKSpriteNode!
  let player = SKSpriteNode(imageNamed: "player01_fall_1.png")
  let bomb = SKSpriteNode(imageNamed: "bomb_1")
  
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
    title = SKSpriteNode(imageNamed: "DropCharge_title")
    title.position = CGPoint(x: size.width/2, y: size.height * 0.7)
    fgNode.addChild(title)
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

    player.position = CGPoint(x: size.width / 2, y: 80)
    fgNode.addChild(player)
    player.zPosition = ForegroundZ.Player.rawValue
    
    player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
    player.physicsBody!.dynamic = false
    player.physicsBody!.allowsRotation = false
    player.physicsBody!.categoryBitMask = PhysicsCategory.Player
    player.physicsBody!.collisionBitMask = 0
    
  }

  func setupPhysics() {
    physicsWorld.contactDelegate = self
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
    let scale = SKAction.scaleTo(0, duration: 0.5)
    title.runAction(scale)

    // Add bomb
    bomb.position = player.position
    fgNode.addChild(bomb)
    bomb.zPosition = ForegroundZ.Bomb.rawValue

    // Bounce bomb
    let scaleUp = SKAction.scaleTo(1.25, duration: 0.25)
    let scaleDown = SKAction.scaleTo(1.0, duration: 0.25)
    let sequence = SKAction.sequence([scaleUp, scaleDown])
    let repeat = SKAction.repeatActionForever(sequence)
    bomb.runAction(repeat)
    
    // Switch to playing state
    runAction(SKAction.sequence([
      SKAction.waitForDuration(2.0),
      SKAction.runBlock(switchToPlaying)
    ]))
  
  }
  
  func switchToPlaying() {
  
    // Switch game state
    gameState = .Playing
    
    // Stop bomb
    bomb.removeFromParent()
    
    // Start player movement
    player.physicsBody!.dynamic = true
    superBoostPlayer()
    
  }
  
  // MARK: Touch Handling
  func handlePlayingTouches(touches: NSSet) {
    if let touch = touches.anyObject() as? UITouch {
      let touchTarget = touch.locationInNode(self)
      let xVelocity = touchTarget.x < player.position.x ? CGFloat(-150.0) : CGFloat(150.0)
      player.physicsBody!.velocity.dx = xVelocity
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
  
    let target = player.position
    var targetPosition = CGPoint(x: worldNode.position.x, y: -(target.y - size.height * 0.4))
    var newPosition = targetPosition

    self.fgNode.position = newPosition
    self.mgNode.position = CGPoint(x: newPosition.x/5.0, y: newPosition.y/5.0)
    self.bgNode.position = CGPoint(x: newPosition.x/10.0, y: newPosition.y/10.0)
  
  }
  
  func updatePlayer() {
    
    // Set velocity based on core motion
    player.physicsBody?.velocity.dx = xAcceleration * 400.0
  
    // Wrap player around edges of screen
    if player.position.x < -player.size.width/2 {
      player.position.x = size.width + player.size.width/2
    }
    else if player.position.x > size.width + player.size.width/2 {
      player.position.x = -player.size.width/2
    }
  
  }
    
  // MARK: Contacts
  
  func didBeginContact(contact: SKPhysicsContact) {
 
    let other = contact.bodyA.categoryBitMask == PhysicsCategory.Player ? contact.bodyB : contact.bodyA
    
    switch other.categoryBitMask {
      case PhysicsCategory.CoinNormal:
        if let coin = other.node as? SKSpriteNode {
          coin.removeFromParent()
          jumpPlayer()
        }
      case PhysicsCategory.CoinSpecial:
        if let coin = other.node as? SKSpriteNode {
          coin.removeFromParent()
          boostPlayer()
        }
      case PhysicsCategory.PlatformNormal:
        if let platform = other.node as? SKSpriteNode {
          if player.physicsBody!.velocity.dy < 0 {
            jumpPlayer()
          }
        }
      case PhysicsCategory.PlatformBreakable:
        if let platform = other.node as? SKSpriteNode {
          if player.physicsBody!.velocity.dy < 0 {
            platform.removeFromParent()
            jumpPlayer()
          }
        }
      default:
      break;
    }
 
  }
  
  // MARK: Helpers
  func setPlayerVelocity(amount:CGFloat) {
    player.physicsBody!.velocity.dy = max(player.physicsBody!.velocity.dy, amount)
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