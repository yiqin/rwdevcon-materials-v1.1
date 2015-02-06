//
//  SessionCell.swift
//  RWDevConCalendar
//
//  Created by Matt Galloway on 01/12/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

class SessionCell: UICollectionViewCell {

  let titleLabel: UILabel
  let speakerLabel: UILabel

  override init(frame: CGRect) {
    let titleLabel = UILabel(frame: CGRectZero)
    titleLabel.font = UIFont.boldSystemFontOfSize(12)
    titleLabel.numberOfLines = 0
    self.titleLabel = titleLabel

    let speakerLabel = UILabel(frame: CGRectZero)
    speakerLabel.font = UIFont.systemFontOfSize(12)
    speakerLabel.numberOfLines = 0
    self.speakerLabel = speakerLabel

    super.init(frame: frame)

    self.layer.borderColor = UIColor.blackColor().CGColor
    self.layer.borderWidth = 1.0

    self.contentView.addSubview(titleLabel)
    self.contentView.addSubview(speakerLabel)
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let bounds = self.contentView.bounds
    let padding: CGFloat = 5.0
    let paddedWidth = CGRectGetWidth(bounds) - (2.0 * padding)

    let titleLabelSize = self.titleLabel.sizeThatFits(CGSizeMake(paddedWidth, CGFloat.max))

    if self.speakerLabel.text != nil && countElements(self.speakerLabel.text!) > 0 {
      self.titleLabel.frame = CGRect(origin: CGPoint(x: padding, y: padding), size: titleLabelSize)

      let speakerLabelSize = self.speakerLabel.sizeThatFits(CGSizeMake(paddedWidth, CGFloat.max))
      self.speakerLabel.frame = CGRect(origin: CGPoint(x: padding, y: CGRectGetMaxY(bounds) - padding - speakerLabelSize.height), size: speakerLabelSize)
    } else {
      self.titleLabel.bounds = CGRect(origin: CGPointZero, size: titleLabelSize)
      self.titleLabel.center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
    }
  }

}
