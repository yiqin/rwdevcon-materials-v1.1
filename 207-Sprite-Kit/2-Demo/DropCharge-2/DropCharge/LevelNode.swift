//
//  LevelNode.swift
//  DropCharge
//
//  Created by Main Account on 11/28/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit

class LevelNode: SKNode {

  var levelMaxY: CGFloat = 0
  var size = CGSize(width: 320, height: 568)
  
  override init() {
    super.init()
    
    let chunk = create5Across(createPlatformNormalAtPosition)
    chunk.position = CGPoint(x: 0, y: 50)
    addChild(chunk)
    levelMaxY = size.height
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func createCoinNormalAtPosition(position: CGPoint) -> SKSpriteNode {
    let sprite = SKSpriteNode(imageNamed: "powerup05_1")
    sprite.position = position
    sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
    sprite.physicsBody?.dynamic = false
    sprite.physicsBody?.categoryBitMask = PhysicsCategory.CoinNormal
    sprite.physicsBody?.collisionBitMask = 0
    sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Player
    return sprite
  }
  
  func createCoinSpecialAtPosition(position: CGPoint) -> SKSpriteNode {
    let sprite = SKSpriteNode(imageNamed: "powerup01_1")
    sprite.position = position
    sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
    sprite.physicsBody?.dynamic = false
    sprite.physicsBody?.categoryBitMask = PhysicsCategory.CoinSpecial
    sprite.physicsBody?.collisionBitMask = 0
    sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Player
    return sprite
  }
  
  func createPlatformNormalAtPosition(position: CGPoint) -> SKSpriteNode {
    let sprite = SKSpriteNode(imageNamed: "platform01_1")
    sprite.position = position
    sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
    sprite.physicsBody?.dynamic = false
    sprite.physicsBody?.categoryBitMask = PhysicsCategory.PlatformNormal
    sprite.physicsBody?.collisionBitMask = 0
    sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Player
    return sprite
  }
  
  func createPlatformBreakableAtPosition(position: CGPoint) -> SKSpriteNode {
    let sprite = SKSpriteNode(imageNamed: "block_break01")
    sprite.position = position
    sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
    sprite.physicsBody?.dynamic = false
    sprite.physicsBody?.categoryBitMask = PhysicsCategory.PlatformBreakable
    sprite.physicsBody?.collisionBitMask = 0
    sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Player
    return sprite
  }

  func levelSpawnRandom() {
    
    let randNum = Int.random(min: 0, max: 4)
    
    var chunks = [SKSpriteNode]()
    if randNum == 0 {
      chunks.append(create5Across(createPlatformNormalAtPosition))
    } else if randNum == 1 {
      chunks.append(create5Across(createPlatformBreakableAtPosition))
    }
    else if randNum == 2 {
      let platformSpawner = Int.random(min: 0, max: 1) == 0 ? createPlatformNormalAtPosition : createPlatformBreakableAtPosition
      let chunk1 = createSingle(platformSpawner)
      let chunk2 = createSingle(createCoinNormalAtPosition)
      for node in chunk2.children {
        if node.position.y > chunk1.size.height {
          node.removeFromParent()
        }
      }
      chunks.append(chunk1)
      chunks.append(chunk2)
    } else if randNum == 3 {
       chunks.append(createCross(createCoinNormalAtPosition, createCoinSpecialAtPosition))
    } else {
       chunks.append(createLine(createCoinNormalAtPosition, createCoinSpecialAtPosition))
    }
    
    for chunk in chunks {
      chunk.position = CGPointMake(0, levelMaxY)
      self.addChild(chunk)
    }
    levelMaxY += chunks[0].size.height

  }
  
  func levelSpawnTest() -> SKSpriteNode {
    let chunk = SKSpriteNode()
    chunk.addChild(createCoinNormalAtPosition(CGPoint(x: 160, y: 0)))
    chunk.addChild(createCoinNormalAtPosition(CGPoint(x: 160, y: 50)))
    chunk.addChild(createCoinNormalAtPosition(CGPoint(x: 160, y: 100)))
    chunk.addChild(createCoinSpecialAtPosition(CGPoint(x: 160, y: 150)))
    chunk.addChild(createPlatformNormalAtPosition(CGPoint(x: 160, y: 200)))
    chunk.addChild(createPlatformBreakableAtPosition(CGPoint(x: 160, y: 250)))
    chunk.size = CGSize(width: size.width, height: 350)
    return chunk
  }
  
  func create5Across(spawner:(CGPoint) -> SKSpriteNode) -> SKSpriteNode {
    let chunk = SKSpriteNode()
    for i in 0...5 {
      chunk.addChild(spawner(CGPoint(x: 40 + 60 * i, y: 0)))
    }
    chunk.size = CGSize(width: size.width, height: 100)
    return chunk
  }
  
  func createSingle(spawner:(CGPoint) -> SKSpriteNode) -> SKSpriteNode {
    let chunk = SKSpriteNode()
    
    let randomNumSingles = Int.random(min: 5, max: 20)
    for i in 0...randomNumSingles {
      chunk.addChild(spawner(CGPoint(x: CGFloat.random(min: 0, max: size.width), y: 50.0*CGFloat(i))))
    }

    chunk.size = CGSize(width: size.width, height: 50 * CGFloat(randomNumSingles) + 100)
    
    return chunk
  }
  
  func createCross(spawner1:(CGPoint) -> SKSpriteNode, spawner2:(CGPoint) -> SKSpriteNode) -> SKSpriteNode {
    let chunk = SKSpriteNode()
    
    let randomX = CGFloat.random(min: 50, max: size.width - 100)
    
    chunk.addChild(spawner1(CGPoint(x: randomX, y: 100)))
    chunk.addChild(spawner1(CGPoint(x: randomX - 50, y: 50)))
    chunk.addChild(spawner2(CGPoint(x: randomX, y: 50)))
    chunk.addChild(spawner1(CGPoint(x: randomX + 50, y: 50)))
    chunk.addChild(spawner1(CGPoint(x: randomX, y: 0)))
    
    chunk.size = CGSize(width: size.width, height: 150)
    
    return chunk
  }
  
  func createLine(spawner1:(CGPoint) -> SKSpriteNode, spawner2:(CGPoint) -> SKSpriteNode) -> SKSpriteNode {
    let chunk = SKSpriteNode()
    
    let numToSpawn = Int.random(min: 5, max: 30)
    var startX = CGFloat.random(min: 50, max: size.width-50)
    var direction = CGFloat(1.0)
    
    for i in 0..<numToSpawn {

      let yPosition = 50.0*CGFloat(i)
      let spawner = i == numToSpawn-1 ? spawner2 : spawner1
    
      chunk.addChild(spawner(CGPoint(x: startX, y: yPosition)))
      chunk.addChild(spawner(CGPoint(x: startX + 40, y: yPosition)))
      
      if (direction > 0 && startX + 100 > size.width) ||
         (direction < 0 && startX < 50) {
        direction *= -1
      }
      startX = startX + (50 * direction)

    }
    
    chunk.size = CGSize(width: size.width, height: 50.0*CGFloat(numToSpawn) + 100)
    
    return chunk
  }

  func update() {
    
    let lowerLeft = CGPoint(x: 0, y: 0)
    let upperLeft = CGPoint(x: 0, y: size.height)
    let visibleMinYFg = scene!.convertPoint(lowerLeft, toNode: self).y
    let visibleMaxYFg = scene!.convertPoint(upperLeft, toNode: self).y
    
    while visibleMaxYFg > levelMaxY {
      levelSpawnRandom()
    }
    
    for node in children {
      if let sprite = node as? SKSpriteNode {
        if sprite.position.y + sprite.size.height < visibleMinYFg - size.height {
          sprite.removeFromParent()
        }
      }
    }
    
  }


}