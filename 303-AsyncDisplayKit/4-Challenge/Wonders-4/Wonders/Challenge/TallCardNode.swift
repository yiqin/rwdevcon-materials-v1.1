//
//  CardNode.swift
//  Wonders
//
//  Created by Rene Cacheaux on 1/28/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class TallCardNode: ASCellNode {
  let imageNode: ASImageNode
  let titleTextNode: ASTextNode
  let descriptionTextNode: ASTextNode
  var frameSetOrNil: FrameSet?
  
  
  init!(card: Card) {
    // Create Nodes
    imageNode = ASImageNode()
    titleTextNode = ASTextNode()
    descriptionTextNode = ASTextNode()
    
    super.init()
    
    // Set Up Nodes
    backgroundColor = UIColor.blackColor()
    imageNode.image = card.image
    titleTextNode.attributedString = NSAttributedString.attributedStringForTitleText(card.name)
    descriptionTextNode.attributedString = NSAttributedString.attributedStringForDescriptionText(card.description)
    
    // Build Hierarchy
    addSubnode(imageNode)
    addSubnode(titleTextNode)
    addSubnode(descriptionTextNode)
  }
  
  override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    var cardSize = CGSizeZero
    // Measure subnodes
    let imageSize = imageNode.measure(constrainedSize)
    titleTextNode.measure(imageSize)
    let narrowConstrainedSize = CGSize(width: imageSize.width, height: constrainedSize.height)
    var textContentSize = descriptionTextNode.measure(narrowConstrainedSize.sizeByInsetting(width: 40.0, height: 40.0))
    textContentSize.width += 40.0
    textContentSize.height += 60.0
    
    cardSize.width = max(imageSize.width, textContentSize.width)
    cardSize.height = imageSize.height + textContentSize.height
    
    // Calculate frames
    frameSetOrNil = FrameSet(node: self, calculatedSize: cardSize)
    
    // Return calculated size
    return cardSize
  }
  
  override func layout() {
    if let frames = frameSetOrNil {
      imageNode.frame = frames.imageFrame
      titleTextNode.frame = frames.titleFrame
      descriptionTextNode.frame = frames.descriptionFrame
    }
  }
}

extension TallCardNode {
  class FrameSet {
    let imageFrame: CGRect
    let titleFrame: CGRect
    let descriptionFrame: CGRect
    
    init(node: TallCardNode, calculatedSize: CGSize) {
      // Image
      imageFrame = CGRect(origin: CGPointZero, size: node.imageNode.calculatedSize).integerRect
      
      // Title
      var calculatedTitleFrame = CGRect(origin: CGPointZero, size: node.titleTextNode.calculatedSize)
      calculatedTitleFrame.origin.x = imageFrame.origin.x + 12.0
      calculatedTitleFrame.origin.y = imageFrame.maxY - 40.0
      titleFrame = calculatedTitleFrame.integerRect.integerRect
      
      // Description
      descriptionFrame = CGRect(origin: CGPoint(x: 20.0, y: imageFrame.maxY + 20.0), size: node.descriptionTextNode.calculatedSize).integerRect
    }
  }
}

