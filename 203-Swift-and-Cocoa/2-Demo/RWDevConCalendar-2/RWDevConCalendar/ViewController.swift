//
//  ViewController.swift
//  RWDevConCalendar
//
//  Created by Matt Galloway on 30/11/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

extension SessionCell {

  func setupWithSession(session: Session) {
    switch session.track {
    case .Generic:
      self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
    case .Beginner:
      self.backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 0.8, alpha: 1.0)
    case .Intermediate:
      self.backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 0.8, alpha: 1.0)
    case .Advanced:
      self.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.8, alpha: 1.0)
    }

    self.titleLabel.text = session.title
    self.speakerLabel.text = session.speaker

    self.setNeedsLayout()
  }

}

class ViewController: UICollectionViewController {

  private let CELL_IDENTIFIER = "Cell"
  private let DAY_COLUMN_IDENTIFIER = "DayColumn"
  private let TIME_ROW_IDENTIFIER = "TimeRow"

  private let PRESENT_SESSION_SEGUE_IDENTIFIER = "PresentSession"

  private var days = [NSDate]()
  private var sessions = [[Session]]()

  private lazy var timeRowDateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "h a"
    return formatter
  }()

  private lazy var dayColumnDateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "EEE MMM d"
    return formatter
    }()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.loadData()

    self.edgesForExtendedLayout = .None
    self.title = "RWDevCon"
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)

    self.collectionView?.backgroundColor = UIColor(white: 0.922, alpha: 1.0)

    let layout = MSCollectionViewCalendarLayout()
    self.collectionView?.collectionViewLayout = layout
    layout.delegate = self
    layout.sectionLayoutType = .HorizontalTile
    layout.headerLayoutType = .TimeRowAboveDayColumn
    layout.timeRowHeaderWidth = 46
    layout.sectionWidth = 402

    self.collectionView?.registerClass(SessionCell.self, forCellWithReuseIdentifier: CELL_IDENTIFIER)
    self.collectionView?.registerClass(DayColumnHeader.self, forSupplementaryViewOfKind: MSCollectionElementKindDayColumnHeader, withReuseIdentifier: DAY_COLUMN_IDENTIFIER)
    self.collectionView?.registerClass(TimeRowHeader.self, forSupplementaryViewOfKind: MSCollectionElementKindTimeRowHeader, withReuseIdentifier: TIME_ROW_IDENTIFIER)

    // These are optional. If you don't want any of the decoration views, just don't register a class for them.
    layout.registerClass(CurrentTimeGridline.self, forDecorationViewOfKind: MSCollectionElementKindCurrentTimeHorizontalGridline)
    layout.registerClass(Gridline.self, forDecorationViewOfKind: MSCollectionElementKindHorizontalGridline)
    layout.registerClass(Gridline.self, forDecorationViewOfKind: MSCollectionElementKindVerticalGridline)
    layout.registerClass(TimeRowHeaderBackground.self, forDecorationViewOfKind: MSCollectionElementKindTimeRowHeaderBackground)
    layout.registerClass(DayColumnHeaderBackground.self, forDecorationViewOfKind: MSCollectionElementKindDayColumnHeaderBackground)
  }

  private func loadData() {
    let path = NSBundle.mainBundle().pathForResource("sessions", ofType: "json")
    let jsonData = NSData(contentsOfFile: path!)
    let json = JSON(data: jsonData!)

    var data = [NSDate:[Session]]()

    for (key, value) in json {
      let session = createSessionFromJSON(value)
      let day = session.start.rw_beginningOfDay()

      var dayArray = data[day]
      if dayArray == nil {
        dayArray = []
      }
      dayArray!.append(session)
      data[day] = dayArray
    }

    var days = data.keys.array
    days.sort {
      lhs, rhs in
      return lhs.compare(rhs) == NSComparisonResult.OrderedAscending
    }

    var sessions = [[Session]]()
    for day in days {
      sessions.append(data[day]!)
    }

    self.days = days
    self.sessions = sessions
  }

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return self.days.count;
  }

  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.sessions[section].count
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CELL_IDENTIFIER, forIndexPath: indexPath) as SessionCell

    let session = self.sessions[indexPath.section][indexPath.item]
    cell.setupWithSession(session)

    return cell
  }

  override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    switch kind {
    case MSCollectionElementKindDayColumnHeader:
      let dayColumnHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: DAY_COLUMN_IDENTIFIER, forIndexPath: indexPath) as DayColumnHeader
      let day = (self.collectionView?.collectionViewLayout as MSCollectionViewCalendarLayout).dateForDayColumnHeaderAtIndexPath(indexPath)
      dayColumnHeader.titleLabel.text = self.dayColumnDateFormatter.stringFromDate(day)
      dayColumnHeader.setNeedsLayout()
      return dayColumnHeader
    case MSCollectionElementKindTimeRowHeader:
      let timeRowHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: TIME_ROW_IDENTIFIER, forIndexPath: indexPath) as TimeRowHeader
      let time = (self.collectionView?.collectionViewLayout as MSCollectionViewCalendarLayout).dateForTimeRowHeaderAtIndexPath(indexPath)
      timeRowHeader.titleLabel.text = self.timeRowDateFormatter.stringFromDate(time)
      timeRowHeader.setNeedsLayout()
      return timeRowHeader
    default:
      fatalError("Unhandled supplementary kind")
    }
  }

  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let session = self.sessions[indexPath.section][indexPath.item]
    let alert = UIAlertController(title: "Session tapped", message: "You tapped session:\n\(session.title)", preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
  }

}

extension ViewController: MSCollectionViewDelegateCalendarLayout {

  func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: MSCollectionViewCalendarLayout!, dayForSection section: Int) -> NSDate! {
    return self.days[section]
  }

  func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: MSCollectionViewCalendarLayout!, startTimeForItemAtIndexPath indexPath: NSIndexPath!) -> NSDate! {
    let session = self.sessions[indexPath.section][indexPath.item]
    return session.start
  }

  func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: MSCollectionViewCalendarLayout!, endTimeForItemAtIndexPath indexPath: NSIndexPath!) -> NSDate! {
    let session = self.sessions[indexPath.section][indexPath.item]
    return session.end
  }

  func currentTimeComponentsForCollectionView(collectionView: UICollectionView!, layout collectionViewLayout: MSCollectionViewCalendarLayout!) -> NSDate! {
    return NSDate()
  }

}
