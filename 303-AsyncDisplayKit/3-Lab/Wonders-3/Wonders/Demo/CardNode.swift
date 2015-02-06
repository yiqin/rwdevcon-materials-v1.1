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
    
    backgroundColor = UIColor(white: 1.0, alpha: 0.05)
    
    // Set Up Nodes
    imageNode.image = card.image
    titleTextNode.attributedString = NSAttributedString.attributedStringForTitleText(card.name)
    moreButtonNode.image = moreImage
    moreButtonNode.alpha = 0.0
    blurredImageNode.image = card.image
    blurredImageNode.imageModificationBlock = blurredImageNode.blurClosure
    blurredImageNode.alpha = 0.0
    descriptionTextNode.attributedString = NSAttributedString.attributedStringForDescriptionText(card.description)
    descriptionTextNode.alpha = 0.0
    
    // Wire Target Action Pairs
    moreButtonNode.addTarget(self, action: "handleMoreButtonTap", forControlEvents: ASControlNodeEvent.TouchUpInside)
    
    // Build Hierarchy
    addSubnode(imageNode)
    addSubnode(blurredImageNode)
    addSubnode(titleTextNode)
    addSubnode(moreButtonNode)
    addSubnode(descriptionTextNode)
  }
  
  override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    // Measure subnodes
    let cardSize = imageNode.measure(constrainedSize)
    titleTextNode.measure(cardSize)
    moreButtonNode.measure(cardSize)
    descriptionTextNode.measure(cardSize.sizeByInsetting(width: 40.0, height: 40.0))
    
    // Calculate frames
    frameSetOrNil = FrameSet(node: self)
    
    // Return calculated size
    return cardSize
  }
  
  override func layout() {
    if let frames = frameSetOrNil {
      imageNode.frame = frames.imageFrame
      titleTextNode.frame = frames.titleFrame
      moreButtonNode.frame = frames.moreButtonFrame
      blurredImageNode.frame = frames.imageFrame
      descriptionTextNode.frame = frames.descriptionFrame
    }
  }
  
  override func subnodeDisplayWillStart(subnode: ASDisplayNode!) {
    super.subnodeDisplayWillStart(subnode)
    if subnode == blurredImageNode {
      moreButtonNode.alpha = 0.0
      descriptionTextNode.alpha = 0.0
      blurredImageNode.alpha = 0.0
    } else if subnode == imageNode {
      imageNode.alpha = 0.0
      titleTextNode.alpha = 0.0
    }
  }
  
  override func subnodeDisplayDidFinish(subnode: ASDisplayNode!) {
    super.subnodeDisplayDidFinish(subnode)
    if subnode == blurredImageNode {
      if displayDescription {
          showDescription()
      }
      UIView.animateWithDuration(0.5) {
        self.moreButtonNode.alpha = 1.0
      }
    } else if subnode == imageNode {
      UIView.animateWithDuration(0.3) {
        self.imageNode.alpha = 1.0
        self.titleTextNode.alpha = 1.0
      }
    }
  }
  
  func handleMoreButtonTap() {
    if !displayDescription {
      showDescription()
    } else {
      hideDescription()
    }
  }
  
  func showDescription() {
    displayDescription = true
    if let frames = frameSetOrNil {
      UIView.animateWithDuration(0.5) {
        self.moreButtonNode.image = self.closeImage
        self.blurredImageNode.alpha = 1.0
        self.descriptionTextNode.alpha = 1.0
      }
    }
  }
  
  func hideDescription() {
    displayDescription = false
    UIView.animateWithDuration(0.5) {
      self.moreButtonNode.image = self.moreImage
      self.blurredImageNode.alpha = 0.0
      self.descriptionTextNode.alpha = 0.0
    }
  }
}
