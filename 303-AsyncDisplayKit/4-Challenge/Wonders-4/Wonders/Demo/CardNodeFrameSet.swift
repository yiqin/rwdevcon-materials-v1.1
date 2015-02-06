//
//  CardNodeFrameSet.swift
//  Wonders
//
//  Created by Rene Cacheaux on 1/28/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

extension CardNode {
  class FrameSet {
    let imageFrame: CGRect
    let titleFrame: CGRect
    let moreButtonFrame: CGRect
    let descriptionFrame: CGRect
    
    init(node: CardNode) {
      // Image
      imageFrame = CGRect(origin: CGPointZero, size: node.imageNode.calculatedSize).integerRect
      
      // Title
      var calculatedTitleFrame = CGRect(origin: CGPointZero, size: node.titleTextNode.calculatedSize)
      calculatedTitleFrame.origin.x = imageFrame.origin.x + 12.0
      calculatedTitleFrame.origin.y = imageFrame.maxY - 40.0
      titleFrame = calculatedTitleFrame.integerRect.integerRect
      
      // More Button
      var moreButtonOrigin = CGPoint(x: imageFrame.maxX, y: imageFrame.minY)
      moreButtonOrigin.x -= (node.moreButtonNode.calculatedSize.width + 10.0)
      moreButtonOrigin.y += 10.0
      moreButtonFrame = CGRect(origin: moreButtonOrigin, size: node.moreButtonNode.calculatedSize).integerRect
      
      // Description
      descriptionFrame = CGRect(origin: CGPoint(x: 20, y: 54), size: node.descriptionTextNode.calculatedSize).integerRect
    }
  }
}
