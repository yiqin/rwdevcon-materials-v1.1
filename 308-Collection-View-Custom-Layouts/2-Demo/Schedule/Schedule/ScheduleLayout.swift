//
//  ScheduleLayout.swift
//  Schedule
//
//  Created by Mic Pringle on 29/01/2015.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class ScheduleLayout: UICollectionViewLayout {
  
  private lazy var dataSource: ScheduleDataSource = {
    return self.collectionView!.dataSource as ScheduleDataSource
  }()
  
  private let widthPerHour: CGFloat = 180
  
  struct Frame {
    var rect: CGRect
    var indexPath: NSIndexPath
  }
  
  var sessionFrames: [Frame] = []
  
  private func frameForSession(session: Session, atIndexPath indexPath: NSIndexPath) -> CGRect {
    let heightPerTrack = collectionViewContentSize().height / CGFloat(dataSource.numberOfTracksInSchedule)
    let width = widthPerHour * CGFloat(session.length)
    let x = (CGFloat(session.hour) * widthPerHour) + (widthPerHour * CGFloat(session.offset))
    let y = heightPerTrack * CGFloat(indexPath.item)
    let frame = CGRect(x: x, y: y, width: width, height: heightPerTrack)
    return frame
  }
  
  override func collectionViewContentSize() -> CGSize {
    let hoursInSchedule = CGFloat(dataSource.numberOfHoursInSchedule)
    let height = CGRectGetHeight(collectionView!.bounds) - collectionView!.contentInset.top
    let width = hoursInSchedule * widthPerHour
    return CGSizeMake(width, height)
  }
  
  override func prepareLayout() {
    super.prepareLayout()
    
    if sessionFrames.isEmpty {
      for section in 0..<collectionView!.numberOfSections() {
        for item in 0..<collectionView!.numberOfItemsInSection(section) {
          let indexPath = NSIndexPath(forItem: item, inSection: section)
          let rect = frameForSession(dataSource.sessionForIndexPath(indexPath), atIndexPath: indexPath)
          let frame = Frame(rect: rect, indexPath: indexPath)
          sessionFrames.append(frame)
        }
      }
    }
  }
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    for frame in sessionFrames {
      if CGRectIntersectsRect(frame.rect, rect) {
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: frame.indexPath)
        attributes.frame = frame.rect
        layoutAttributes.append(attributes)
      }
    }
    return layoutAttributes
  }
  
}
