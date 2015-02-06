//
//  CalendarViews.swift
//  RWDevConCalendar
//
//  Created by Matt Galloway on 01/12/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

class Gridline: UICollectionReusableView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.lightGrayColor()
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}

class CurrentTimeGridline: UICollectionReusableView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor(red: 0.0, green: 0.408, blue: 0.216, alpha: 1.0)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}

class TimeRowHeaderBackground: UICollectionReusableView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor(red: 0.141, green: 0.122, blue: 0.129, alpha: 1.0)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}

class DayColumnHeaderBackground: UICollectionReusableView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor(red: 0.0, green: 0.408, blue: 0.216, alpha: 1.0)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}

class TimeRowHeader: UICollectionReusableView {

  let titleLabel: UILabel

  override init(frame: CGRect) {
    let titleLabel = UILabel(frame: CGRectZero)
    titleLabel.font = UIFont.systemFontOfSize(12)
    titleLabel.textColor = UIColor.whiteColor()
    self.titleLabel = titleLabel

    super.init(frame: frame)

    self.addSubview(titleLabel)
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.titleLabel.sizeToFit()
    self.titleLabel.center = CGPoint(
      x: CGRectGetWidth(self.bounds) - 5.0 - (CGRectGetWidth(self.titleLabel.bounds) / 2.0),
      y: CGRectGetHeight(self.bounds) / 2.0)
  }

}

class DayColumnHeader: UICollectionReusableView {

  private let bubbleView: UIView
  let titleLabel: UILabel

  override init(frame: CGRect) {
    let bubbleView = UIView(frame: CGRectZero)
    bubbleView.backgroundColor = UIColor.whiteColor()
    self.bubbleView = bubbleView

    let titleLabel = UILabel(frame: CGRectZero)
    titleLabel.font = UIFont.boldSystemFontOfSize(17.0)
    titleLabel.textColor = UIColor.blackColor()
    self.titleLabel = titleLabel

    super.init(frame: frame)

    self.addSubview(bubbleView)
    self.addSubview(titleLabel)
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.titleLabel.sizeToFit()
    self.titleLabel.center = CGPoint(
      x: CGRectGetWidth(self.bounds) / 2.0,
      y: CGRectGetHeight(self.bounds) / 2.0)

    self.bubbleView.frame = CGRectInset(self.titleLabel.frame, -10.0, -5.0)
    self.bubbleView.layer.cornerRadius = CGRectGetHeight(self.bubbleView.bounds) / 2.0
  }

}
