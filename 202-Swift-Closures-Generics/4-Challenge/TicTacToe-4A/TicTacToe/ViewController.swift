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

  private var grid = Grid<Player>(columns: 3, rows: 3)

  private var player = Player.X

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.board.touchHandler = { position in
      println("Pressed \(position.asString())")

      if let player = self.grid[position] {
        println("Play already exists at this position!")
      } else {
        let lastMove = (position: position, player: self.player)

        self.grid[position] = self.player
        self.board.drawPlayer(self.player, atPosition: position)
        self.player = self.player.opposite()

        self.checkEnd(lastMove)
      }
    }
  }

  private func reset() {
    self.grid = Grid(columns: 3, rows: 3)
    self.board.reset()
  }

  private func checkEnd(lastMove: (position: Position, player: Player)) {
    if checkWin(self.grid, lastMove.position, lastMove.player) {
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
        _ in self.reset()
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
