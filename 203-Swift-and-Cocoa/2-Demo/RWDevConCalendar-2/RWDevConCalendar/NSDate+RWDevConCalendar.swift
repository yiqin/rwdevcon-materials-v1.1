//
//  NSDate+RWDevConCalendar.swift
//  RWDevConCalendar
//
//  Created by Matt Galloway on 28/01/2015.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation

extension NSDate {
  func rw_beginningOfDay() -> NSDate {
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate: self)
    return calendar.dateFromComponents(components)!
  }
}
