//
//  Constants.swift
//  DropCharge
//
//  Created by Main Account on 11/28/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit

enum GameState {
case WaitingForTap
case WaitingForBomb
case Playing
case GameOver
}

struct PhysicsCategory {
static let None: UInt32              = 0
static let Player: UInt32            = 0b1      // 1
static let PlatformNormal: UInt32    = 0b10     // 2
static let PlatformBreakable: UInt32 = 0b100    // 4
static let CoinNormal: UInt32        = 0b1000   // 8
static let CoinSpecial: UInt32       = 0b10000  // 16
static let Edges: UInt32             = 0b100000 // 32
}

enum ForegroundZ: CGFloat {
case Level
case Bomb
case Lava
case Player
}