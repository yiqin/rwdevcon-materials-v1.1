//
//  Clock.swift
//  RWDevCon
//
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class Clock {
  
  class func imageForSession(session: Session) -> UIImage? {
    if let hourImage = UIImage(named: "H\(session.startHourString)") {
      if let minuteImage = UIImage(named: "M\(session.startMinuteString)") {
        let rect = CGRect(x: 0, y: 0, width: 22, height: 22)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        minuteImage.drawInRect(rect)
        hourImage.drawInRect(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
      }
    }
    return nil
  }
  
}
