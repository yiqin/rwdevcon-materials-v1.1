//
//  DataStructures.swift
//  TicTacToe
//
//  Created by Matt Galloway on 15/11/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation
import UIKit

enum Player: Equatable {
  case X(avatar: UIImage)
  case O
}

func ==(lhs: Player, rhs: Player) -> Bool {
  switch (lhs, rhs) {
  case (.X, .X):
    return true
  case (.O, .O):
    return true
  default:
    return false
  }
}

struct Position: Hashable {
  let column: Int
  let row: Int

  func asString() -> String {
    return "\(column):\(row)"
  }

  var hashValue: Int {
    return column * 10 + row
  }
}

func ==(lhs: Position, rhs: Position) -> Bool {
  return lhs.column == rhs.column && lhs.row == rhs.row
}
