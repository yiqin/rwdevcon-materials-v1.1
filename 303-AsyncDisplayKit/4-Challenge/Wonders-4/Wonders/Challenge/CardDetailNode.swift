//
//  CardDetailNode.swift
//  Wonders
//
//  Created by Rene Cacheaux on 1/31/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class CardDetailNode: ASDisplayNode {
  let titleTextNode = ASTextNode()
  let locationTextNode = ASTextNode()
  let descriptionTextNode = ASTextNode()
  let yearBuiltTextNode = ASTextNode()
  let backgroundBlurNode = ASImageNode()
  let closeButtonNode = ASImageNode()
  var exitClosure: (()->())?
  
  init(card: Card) {
    super.init()
    
    titleTextNode.attributedString = NSAttributedString.attributedStringForTitleText(card.name)
    locationTextNode.attributedString = NSAttributedString.attributedStringForSubtitleText(card.location)
    locationTextNode.alpha = 0.0
    descriptionTextNode.attributedString = NSAttributedString.attributedStringForDescriptionText(card.detailDescription)
    descriptionTextNode.alpha = 0.0
    yearBuiltTextNode.attributedString = NSAttributedString.attributedStringForDescriptionText(card.yearBuilt)
    yearBuiltTextNode.alpha = 0.0
    backgroundBlurNode.image = card.image
    backgroundBlurNode.contentMode = .ScaleAspectFill
    backgroundBlurNode.imageModificationBlock = backgroundBlurNode.blurClosure
    backgroundBlurNode.alpha = 0.0
    closeButtonNode.image = UIImage(named: "Close")
    
    closeButtonNode.addTarget(self, action: "exit", forControlEvents: ASControlNodeEvent.TouchUpInside)
    
    addSubnode(backgroundBlurNode)
    addSubnode(titleTextNode)
    addSubnode(locationTextNode)
    addSubnode(descriptionTextNode)
    addSubnode(yearBuiltTextNode)
    addSubnode(closeButtonNode)
  }
  
  override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    let containerSize = constrainedSize.sizeByInsetting(width: 40, height: 40)
    titleTextNode.measure(containerSize)
    locationTextNode.measure(containerSize)
    descriptionTextNode.measure(containerSize)
    yearBuiltTextNode.measure(containerSize)
    closeButtonNode.measure(containerSize)
    return constrainedSize
  }
  
  override func layout() {
    backgroundBlurNode.frame = CGRect(origin: CGPointZero, size: calculatedSize)
    titleTextNode.frame = CGRect(origin: CGPoint(x: 20, y: 67), size: titleTextNode.calculatedSize)
    locationTextNode.frame = CGRect(origin: titleTextNode.frame.origin.pointByOffsetting(x: 0, y: titleTextNode.calculatedSize.height + 0), size: locationTextNode.calculatedSize)
    descriptionTextNode.frame = CGRect(origin: locationTextNode.frame.origin.pointByOffsetting(x: 0, y: locationTextNode.calculatedSize.height + 20), size: descriptionTextNode.calculatedSize)
    var yearBuiltOrigin = CGPointZero
    yearBuiltOrigin.x = (calculatedSize.width - yearBuiltTextNode.calculatedSize.width) / 2.0
    yearBuiltOrigin.y = calculatedSize.height - 50
    yearBuiltTextNode.frame = CGRect(origin: yearBuiltOrigin, size: yearBuiltTextNode.calculatedSize)
    closeButtonNode.frame = CGRect(origin: CGPoint(x: calculatedSize.width - closeButtonNode.calculatedSize.width - 10, y: 10), size: closeButtonNode.calculatedSize)
  }
  
  override func subnodeDisplayDidFinish(subnode: ASDisplayNode!) {
    super.subnodeDisplayDidFinish(subnode)
    if subnode == backgroundBlurNode {
      UIView.animateWithDuration(0.5) {
        self.backgroundBlurNode.alpha = 1.0
        self.locationTextNode.alpha = 1.0
        self.descriptionTextNode.alpha = 1.0
        self.yearBuiltTextNode.alpha = 1.0
      }
    }
  }
  
  func exit() {
    recursivelyReclaimMemory()
    exitClosure?()
  }
}
