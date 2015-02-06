//
//  CardNode.swift
//  Wonders
//
//  Created by Rene Cacheaux on 1/28/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class CardNode: ASCellNode {
  let imageNode: ASImageNode
  let titleTextNode: ASTextNode
  let moreButtonNode: ASImageNode
  let blurredImageNode: ASImageNode
  let descriptionTextNode: ASTextNode
  
  var frameSetOrNil: FrameSet?
  
  let moreImage = UIImage(named: "More")!
  let closeImage = UIImage(named: "Close")!
  
  var displayDescription = false
  
  
  init!(card: Card) {
    // Create Nodes
    imageNode = ASImageNode()
    titleTextNode = ASTextNode()
    moreButtonNode = ASImageNode()
    blurredImageNode = ASImageNode()
    descriptionTextNode = ASTextNode()
    
    super.init()
    
    // Set Up Nodes
    imageNode.image = card.image
    titleTextNode.attributedString = NSAttributedString.attributedStringForTitleText(card.name)
    
    // Wire Target Action Pairs
    
    // Build Hierarchy
    addSubnode(imageNode)
    addSubnode(titleTextNode)
  }
  
  override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    // Measure subnodes
    let cardSize = imageNode.measure(constrainedSize)
    titleTextNode.measure(cardSize)
    
    // Calculate frames
    frameSetOrNil = FrameSet(node: self)
    
    // Return calculated size
    return cardSize
  }
  
  override func layout() {
    if let frames = frameSetOrNil {
      imageNode.frame = frames.imageFrame
      titleTextNode.frame = frames.titleFrame
    }
  }
  
  override func subnodeDisplayWillStart(subnode: ASDisplayNode!) {
    super.subnodeDisplayWillStart(subnode)
  
  }
  
  override func subnodeDisplayDidFinish(subnode: ASDisplayNode!) {
    super.subnodeDisplayDidFinish(subnode)
    
  }
  
  func handleMoreButtonTap() {
    if !displayDescription {
      showDescription()
    } else {
      hideDescription()
    }
  }
  
  func showDescription() {

  }
  
  func hideDescription() {

  }
}
