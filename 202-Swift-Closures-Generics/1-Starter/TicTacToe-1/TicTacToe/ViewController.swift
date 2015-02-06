//
//  ViewController.swift
//  TicTacToe
//
//  Created by Matt Galloway on 15/11/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var board: Board!

  private var grid = Grid(columns: 3, rows: 3)

  private var player = Player.X

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.board.delegate = self
  }

  private func reset() {
    self.grid = Grid(columns: 3, rows: 3)
    self.board.reset()
  }

  private func checkEnd(lastMove: (position: Position, player: Player)) {
    let row = lastMove.position.row
    let column = lastMove.position.column

    // --- CUT FROM HERE ---

    // Check row
    var rowWin = true
    for i in 0..<3 {
      if let test = grid[Position(column: i, row: row)] {
        if test != lastMove.player {
          rowWin = false
          break
        }
      } else {
        rowWin = false
        break
      }
    }

    // Check column
    var columnWin = true
    for i in 0..<3 {
      if let test = grid[Position(column: column, row: i)] {
        if test != lastMove.player {
          columnWin = false
          break
        }
      } else {
        columnWin = false
        break
      }
    }

    // Check diagonals
    var diagonalAWin = true
    for i in 0..<3 {
      if let test = grid[Position(column: i, row: i)] {
        if test != lastMove.player {
          diagonalAWin = false
          break
        }
      } else {
        diagonalAWin = false
        break
      }
    }

    var diagonalBWin = true
    for i in 0..<3 {
      if let test = grid[Position(column: i, row: 2-i)] {
        if test != lastMove.player {
          diagonalBWin = false
          break
        }
      } else {
        diagonalBWin = false
        break
      }
    }

    // --- CUT TO HERE ---

    if rowWin || columnWin || diagonalAWin || diagonalBWin {
      println("Winner!")

      var playerString = ""
      switch lastMove.player {
      case .X:
        playerString = "X"
      case .O:
        playerString = "O"
      }

      let alert = UIAlertController(title: "Winner!", message: "\(playerString) has won", preferredStyle: .Alert)

      let action = UIAlertAction(title: "New Game", style: .Default) {
        (alert: UIAlertAction!) -> Void in
        self.reset()
      }

      alert.addAction(action)
      self.presentViewController(alert, animated: true, completion: nil)
      
    } else if grid.countOccupiedSpaces() == 9 {
      println("Game end - no winner")

      let alert = UIAlertController(title: "Too bad", message: "No winner", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "New Game", style: .Default) {
        (alert: UIAlertAction!) -> Void in
        self.reset()
        })
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
}

extension ViewController: BoardDelegate {

  func board(board: Board, didPressPosition position: Position) {
    println("Pressed \(position.asString())")

    if let player = grid[position] {
      println("Play already exists at this position!")
    } else {
      let lastMove = (position: position, player: self.player)

      grid[position] = self.player
      self.board.drawPlayer(self.player, atPosition: position)
      self.player = self.player.opposite()

      checkEnd(lastMove)
    }
  }
}
