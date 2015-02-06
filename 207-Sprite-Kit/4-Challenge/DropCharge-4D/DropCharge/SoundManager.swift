//
//  SoundManager.swift
//  DropCharge
//
//  Created by Main Account on 11/28/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class SoundManager {

  let node: SKNode
  let soundBoost = SKAction.playSoundFileNamed("boost.wav", waitForCompletion: false)
  let soundSuperBoost = SKAction.playSoundFileNamed("nitro.wav", waitForCompletion: false)
  let soundJump = SKAction.playSoundFileNamed("jump.wav", waitForCompletion: false)
  let soundCoin = SKAction.playSoundFileNamed("coin1.wav", waitForCompletion: false)
  let soundBrick = SKAction.playSoundFileNamed("brick.caf", waitForCompletion: false)
  let soundHitLava = SKAction.playSoundFileNamed("DrownFireBug.mp3", waitForCompletion: false)
  let soundTickTock = SKAction.playSoundFileNamed("tickTock.wav", waitForCompletion: false)
  let soundBombDrop = SKAction.playSoundFileNamed("bombDrop.wav", waitForCompletion: false)
  let soundExplosions = [
    SKAction.playSoundFileNamed("explosion1.wav", waitForCompletion: false),
    SKAction.playSoundFileNamed("explosion2.wav", waitForCompletion: false),
    SKAction.playSoundFileNamed("explosion3.wav", waitForCompletion: false),
    SKAction.playSoundFileNamed("explosion4.wav", waitForCompletion: false)
  ]
  let bgMusicAlarm = AVAudioPlayer(contentsOfURL: NSBundle.mainBundle().URLForResource("alarm", withExtension: "wav"), error: nil)
  
  init(node: SKNode) {
    self.node = node
  }
  
  func playMusicAction() {
    SKTAudio.sharedInstance().playBackgroundMusic("bgMusic.mp3")
    bgMusicAlarm.numberOfLoops = -1
    bgMusicAlarm.play()
  }
  
  func playMusicBackground() {
    SKTAudio.sharedInstance().playBackgroundMusic("SpaceGame.caf")    
    bgMusicAlarm.stop()
  }
  
  func playSoundBoost() {
    node.runAction(soundBoost)
  }
  
  func playSoundSuperBoost() {
    node.runAction(soundSuperBoost)
  }
  
  func playSoundJump() {
    node.runAction(soundJump)
  }
  
  func playSoundCoin() {
    node.runAction(soundCoin)
  }
  
  func playSoundBrick() {
    node.runAction(soundBrick)
  }
  
  func playSoundHitLava() {
    node.runAction(soundHitLava)
  }
  
  func playSoundTickTock() {
    let repeatTickTock = SKAction.repeatAction(soundTickTock, count: 2)
    node.runAction(repeatTickTock)
  }
  
  func playSoundBombDrop() {
    node.runAction(soundBombDrop)
  }
  
  func playSoundExplosion(index: Int) {
    if index >= soundExplosions.count {
      return
    }
    let soundExplosion = soundExplosions[index]
    node.runAction(soundExplosion)
  }

}