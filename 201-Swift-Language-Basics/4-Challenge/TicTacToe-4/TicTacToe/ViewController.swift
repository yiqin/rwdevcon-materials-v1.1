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

  private var turns = [Position:Player]()
  private var player = Player.X

  override func viewDidLoad() {
    super.viewDidLoad()
    self.board.delegate = self
  }

  private func reset() {
    self.turns = [:]
    self.board.setNeedsDisplay()
  }

  private func checkEnd(lastMove: (position: Position, player: Player)) {
    let row = lastMove.position.row
    let column = lastMove.position.column

    // Check row
    var rowWin = true
    for i in 0..<3 {
      if let test = self.turns[Position(column: i, row: row)] {
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
      if let test = self.turns[Position(column: column, row: i)] {
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
      if let test = self.turns[Position(column: i, row: i)] {
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
      if let test = self.turns[Position(column: i, row: 2-i)] {
        if test != lastMove.player {
          diagonalBWin = false
          break
        }
      } else {
        diagonalBWin = false
        break
      }
    }

    if rowWin || columnWin || diagonalAWin || diagonalBWin {
      showGameWon(lastMove.player)
    } else if turns.count == 9 {
      showGameEnd()
    }
  }

  private func showGameWon(player: Player) {
    println("Winner!")

    var playerString = ""
    switch player {
    case .X:
      playerString = "X"
    case .O:
      playerString = "O"
    }

    let alert = UIAlertController(title: "Winner!", message: "\(playerString) has won", preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "New Game", style: .Default) {
      (alert: UIAlertAction!) -> Void in
      self.reset()
      })
    self.presentViewController(alert, animated: true, completion: nil)
  }

  private func showGameEnd() {
    println("Game end - no winner")

    let alert = UIAlertController(title: "Too bad", message: "No winner", preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "New Game", style: .Default) {
      (alert: UIAlertAction!) -> Void in
      self.reset()
      })
    self.presentViewController(alert, animated: true, completion: nil)
  }

}

extension ViewController: BoardDelegate {

  func board(board: Board, didPressPosition position: Position) {
    println("Pressed \(position.asString())")

    if let player = self.turns[position] {
      println("Play already exists at this position!")
    } else {
      let lastMove = (position: position, player: self.player)

      self.turns[position] = self.player
      self.player = self.player.opposite()
      self.board.setNeedsDisplay()

      self.checkEnd(lastMove)
    }
  }

  func board(board: Board, playerAtPosition position: Position) -> Player? {
    return self.turns[position]
  }

}
