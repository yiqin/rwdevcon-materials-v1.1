//
//  DataStructures.swift
//  TicTacToe
//
//  Created by Matt Galloway on 15/11/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation

enum Player {
  case X
  case O

  func opposite() -> Player {
    switch self {
    case .X:
      return .O
    case .O:
      return .X
    }
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
