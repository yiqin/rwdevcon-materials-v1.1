//
//  ScheduleDataSource.swift
//  Schedule
//
//  Created by Mic Pringle on 21/11/2014.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

typealias CellConfigurationBlock = (cell: ScheduleCell, indexPath: NSIndexPath, session: Session) -> ()
typealias HeaderConfigurationBlock = (header: ScheduleHeader, indexPath: NSIndexPath, group: Group, kind: String) -> ()

class ScheduleDataSource: NSObject, UICollectionViewDataSource {
  
  let numberOfTracksInSchedule = 3
  let numberOfHoursInSchedule = 11
  
  var cellConfigurationBlock: CellConfigurationBlock?
  var headerConfigurationBlock: HeaderConfigurationBlock?
  
  private lazy var schedule: [Group] = {
    let path = NSBundle.mainBundle().pathForResource("Schedule", ofType: "plist")
    var schedule: [Group] = []
    if let contents = NSArray(contentsOfFile: path!) as? [NSDictionary] {
      for dictionary in contents {
        let group = Group(dictionary: dictionary)
        schedule.append(group)
      }
    }
    return schedule
  }()
  private let trackHeaderTitles = ["Beginner", "Intermediate", "Advanced"]
  private let hourHeaderTitles = ["08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00"]
  
  // MARK: UICollectionViewDataSource
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return schedule.count
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let group = schedule[section] as Group
    return group.sessions.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ScheduleCell", forIndexPath: indexPath) as ScheduleCell
    let group = schedule[indexPath.section]
    let session = group.sessions[indexPath.item]
    if let configureBlock = cellConfigurationBlock {
      configureBlock(cell: cell, indexPath: indexPath, session: session)
    }
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ScheduleHeader", forIndexPath: indexPath) as ScheduleHeader
    let group = schedule[indexPath.section]
    if let configurationBlock = headerConfigurationBlock {
      configurationBlock(header: header, indexPath: indexPath, group: group, kind: kind)
    }
    return header
  }
  
  // MARK: Public Utilites
  
  internal func indexPathsOfHourHeaderViews() -> NSArray {
    let indexPaths = NSMutableArray()
    for item in 0..<numberOfHoursInSchedule {
      let indexPath = NSIndexPath(forItem: item, inSection: 0)
      indexPaths.addObject(indexPath)
    }
    return indexPaths
  }
    
  internal func indexPathsOfTrackHeaderViews() -> NSArray {
    let indexPaths = NSMutableArray()
    for item in 0..<numberOfTracksInSchedule {
      let indexPath = NSIndexPath(forItem: item, inSection: 0)
      indexPaths.addObject(indexPath)
    }
    return indexPaths
  }
  
  internal func sessionForIndexPath(indexPath: NSIndexPath) -> Session {
    let group = schedule[indexPath.section]
    return group.sessions[indexPath.item]
  }
  
  internal func titleForHourHeaderViewAtIndexPath(indexPath: NSIndexPath) -> String {
    return hourHeaderTitles[indexPath.item]
  }
  
  internal func titleForTrackHeaderViewAtIndexPath(indexPath: NSIndexPath) -> String {
    return trackHeaderTitles[indexPath.item]
  }
    
}