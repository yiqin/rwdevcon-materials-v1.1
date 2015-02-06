//
//  UpcomingGlanceController.swift
//  RWDevCon
//
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import WatchKit

class UpcomingGlanceController: WKInterfaceController {
  
  @IBOutlet weak var sessionLabel: WKInterfaceLabel!
  @IBOutlet weak var timeImage: WKInterfaceImage!
  @IBOutlet weak var timeLabel: WKInterfaceLabel!
  @IBOutlet weak var roomLabel: WKInterfaceLabel!
  
  lazy var coreDataStack = CoreDataStack()
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    if let session = Session.nextFavoriteSession(coreDataStack.context) {
      sessionLabel.setText(session.title)
      if let clockImage = Clock.imageForSession(session) {
        timeImage.setImage(clockImage)
      } else {
        timeImage.setHidden(true)
      }
      timeLabel.setText(session.startTimeShortString)
      roomLabel.setText(session.room.name)
    }
  }
  
}
