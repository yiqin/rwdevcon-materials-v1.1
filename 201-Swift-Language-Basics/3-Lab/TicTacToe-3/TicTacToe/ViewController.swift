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

}

extension ViewController: BoardDelegate {

  func board(board: Board, didPressPosition position: Position) {
    println("Pressed \(position.asString())")

    if let player = self.turns[position] {
      println("Play already exists at this position!")
    } else {
      self.turns[position] = self.player
      self.player = self.player.opposite()
      self.board.setNeedsDisplay()
    }
  }

  func board(board: Board, playerAtPosition position: Position) -> Player? {
    return self.turns[position]
  }

}
