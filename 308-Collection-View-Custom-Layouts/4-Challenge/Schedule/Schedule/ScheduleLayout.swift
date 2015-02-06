//
//  ScheduleLayout.swift
//  Schedule
//
//  Created by Mic Pringle on 30/01/2015.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class ScheduleLayout: UICollectionViewLayout {
  
  private lazy var dataSource: ScheduleDataSource = {
    return self.collectionView!.dataSource as ScheduleDataSource
  }()
  
  private let widthPerHour: CGFloat = 180
  private let hourHeaderHeight: CGFloat = 40
  private let trackHeaderWidth: CGFloat = 120
  
  struct Frame {
    var rect: CGRect
    var indexPath: NSIndexPath
  }
  
  var sessionFrames: [Frame] = []
  var hourHeaderFrames: [Frame] = []
  var trackHeaderFrames: [Frame] = []
  
  private func frameForSession(session: Session, atIndexPath indexPath: NSIndexPath) -> CGRect {
    let heightPerTrack = collectionViewContentSize().height / CGFloat(dataSource.numberOfTracksInSchedule)
    let width = widthPerHour * CGFloat(session.length)
    let x = trackHeaderWidth + ((CGFloat(session.hour) * widthPerHour) + (widthPerHour * CGFloat(session.offset)))
    let y = hourHeaderHeight + (heightPerTrack * CGFloat(indexPath.item))
    let frame = CGRect(x: x, y: y, width: width, height: heightPerTrack)
    return frame
  }
  
  private func frameForHourHeaderViewAtIndexPath(indexPath: NSIndexPath) -> CGRect {
    let frame = CGRect(x: trackHeaderWidth + (widthPerHour * CGFloat(indexPath.item)), y: 0, width: widthPerHour, height: collectionViewContentSize().height)
    return frame
  }
  
  private func frameForTrackHeaderViewAtIndexPath(indexPath: NSIndexPath) -> CGRect {
    let heightPerTrack = (collectionViewContentSize().height - hourHeaderHeight) / CGFloat(dataSource.numberOfTracksInSchedule)
    let frame = CGRect(x: 0, y: hourHeaderHeight + (heightPerTrack * CGFloat(indexPath.item)), width: trackHeaderWidth, height: heightPerTrack)
    return frame
  }
  
  // MARK: UICollectionViewLayout
  
  override func collectionViewContentSize() -> CGSize {
    let hoursInSchedule = CGFloat(dataSource.numberOfHoursInSchedule)
    let height = CGRectGetHeight(collectionView!.bounds) - collectionView!.contentInset.top
    let width = trackHeaderWidth + (hoursInSchedule * widthPerHour)
    return CGSize(width: width, height: height)
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
    
    if hourHeaderFrames.isEmpty {
      for hour in 0..<dataSource.numberOfHoursInSchedule {
        let indexPath = NSIndexPath(forItem: hour, inSection: 0)
        let rect = frameForHourHeaderViewAtIndexPath(indexPath)
        let frame = Frame(rect: rect, indexPath: indexPath)
        hourHeaderFrames.append(frame)
      }
    }
    
    if trackHeaderFrames.isEmpty {
      for track in 0..<dataSource.numberOfTracksInSchedule {
        let indexPath = NSIndexPath(forItem: track, inSection: 0)
        let rect = frameForTrackHeaderViewAtIndexPath(indexPath)
        let frame = Frame(rect: rect, indexPath: indexPath)
        trackHeaderFrames.append(frame)
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
    
    for frame in hourHeaderFrames {
      if CGRectIntersectsRect(frame.rect, rect) {
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: "HourHeader", withIndexPath: frame.indexPath)
        attributes.frame = frame.rect
        attributes.zIndex = -1
        layoutAttributes.append(attributes)
      }
    }
    
    for frame in trackHeaderFrames {
      if CGRectIntersectsRect(frame.rect, rect) {
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: "TrackHeader", withIndexPath: frame.indexPath)
        attributes.frame = frame.rect
        attributes.zIndex = -1
        layoutAttributes.append(attributes)
      }
    }
    
    return layoutAttributes
  }

}
