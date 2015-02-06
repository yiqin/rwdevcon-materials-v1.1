//
//  WinDetection.swift
//  TicTacToe
//
//  Created by Matthijs on 10-12-14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

private typealias Step = (i: Int, row: Int, column: Int) -> Position

private let horizontal: Step = { i, row, _ in Position(column: i, row: row) }
private let vertical: Step = { i, _, column in Position(column: column, row: i) }
private let diagonalA: Step = { i, _, _ in Position(column: i, row: i) }
private let diagonalB: Step = { i, _, _ in Position(column: i, row: 2-i) }

func checkWin<T: Equatable>(grid: Grid<T>, position: Position, player: T) -> Bool {
  let row = position.row
  let column = position.column

  func winInDirection(stepper: Step) -> Bool {
    var win = true
    for i in 0..<3 {
      if let test = grid[stepper(i: i, row: row, column: column)] {
        if test != player {
          win = false
          break
        }
      } else {
        win = false
        break
      }
    }
    return win
  }

  let rowWin = winInDirection(horizontal)
  let columnWin = winInDirection(vertical)
  let diagonalAWin = winInDirection(diagonalA)
  let diagonalBWin = winInDirection(diagonalB)

  return rowWin || columnWin || diagonalAWin || diagonalBWin
}
