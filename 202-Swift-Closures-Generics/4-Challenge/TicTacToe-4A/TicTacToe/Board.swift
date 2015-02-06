//
//  Board.swift
//  TicTacToe
//
//  Created by Matt Galloway on 15/11/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

class Board: UIView {

  typealias TouchHandler = (Position) -> Void
  var touchHandler: TouchHandler?

  private var cellWidth: CGFloat {
    return CGRectGetWidth(self.bounds) / 3.0
  }

  private var cellHeight: CGFloat {
    return CGRectGetHeight(self.bounds) / 3.0
  }

  override func drawRect(rect: CGRect) {
    let width = CGRectGetWidth(self.bounds)
    let height = CGRectGetHeight(self.bounds)

    // Draw background
    UIColor.whiteColor().setFill()
    UIRectFill(self.bounds)

    // Draw lines
    UIColor.blackColor().setFill()
    UIRectFill(CGRectMake(self.cellWidth, 0, 1, height))
    UIRectFill(CGRectMake(self.cellWidth * 2, 0, 1, height))
    UIRectFill(CGRectMake(0, self.cellHeight, width, 1))
    UIRectFill(CGRectMake(0, self.cellHeight * 2, width, 1))
  }

  private func imageForPlayer(player: Player) -> UIImage {
    var image: NSString
    switch player {
    case .X:
      image = "X"
    case .O:
      image = "O"
    }
    return UIImage(named: image)!
  }

  func drawPlayer(player: Player, atPosition position: Position) {
    let image = self.imageForPlayer(player)

    let imageView = UIImageView(image: image)
    self.addSubview(imageView)

    imageView.center = CGPointMake(
      (CGFloat(position.column) + 0.5) * self.cellWidth,
      (CGFloat(position.row) + 0.5) * self.cellHeight)
  }

  func reset() {
    for imageView in subviews as [UIImageView] {
      imageView.removeFromSuperview()
    }
  }

  override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
    let width = CGRectGetWidth(self.bounds)
    let eachWidth = width / 3.0

    let height = CGRectGetHeight(self.bounds)
    let eachHeight = height / 3.0

    for touch in touches {
      let touch = touch as UITouch
      let position = touch.locationInView(self)
      let col = Int(floor(position.x / eachWidth))
      let row = Int(floor(position.y / eachHeight))

      self.touchHandler?(Position(column: col, row: row))
    }
  }
}
