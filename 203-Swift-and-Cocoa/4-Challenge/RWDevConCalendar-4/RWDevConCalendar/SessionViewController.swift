//
//  SessionViewController.swift
//  RWDevConCalendar
//
//  Created by Matt Galloway on 02/12/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {

  var session: Session? = nil {
    didSet {
      self.updateWithCurrentSession()
    }
  }

  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var speakerLabel: UILabel!
  @IBOutlet private var descriptionLabel: UILabel!
  @IBOutlet private var timeLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = "Session"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "shareTapped:")

    self.updateWithCurrentSession()
  }

  private func updateWithCurrentSession() {
    if !self.isViewLoaded() {
      return
    }

    if let session = self.session {
      self.titleLabel.text = session.title
      self.speakerLabel.text = session.speaker
      self.descriptionLabel.text = session.description

      let startDateFormatter = NSDateFormatter()
      startDateFormatter.dateFormat = "EEEE HH:mm"
      let endDateFormatter = NSDateFormatter()
      endDateFormatter.dateFormat = "HH:mm"
      self.timeLabel.text = "\(startDateFormatter.stringFromDate(session.start)) - \(endDateFormatter.stringFromDate(session.end))"
    }
  }

  @objc private func shareTapped(sender: AnyObject) {
    if let session = self.session {
      let activityViewController = UIActivityViewController(activityItems: ["I'm attending \(session.title) at RWDevCon!"], applicationActivities: nil)
      activityViewController.completionHandler = { (activityType: String!, completed: Bool) in
        self.dismissViewControllerAnimated(true, completion: nil)
      }
      self.presentViewController(activityViewController, animated: true, completion: nil)
    }
  }

}
