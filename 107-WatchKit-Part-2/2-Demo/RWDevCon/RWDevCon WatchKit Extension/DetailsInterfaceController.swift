//
//  DetailsInterfaceController.swift
//  RWDevCon
//
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import Foundation
import WatchKit

class DetailsInterfaceController: WKInterfaceController {
  
  @IBOutlet weak var titleLabel: WKInterfaceLabel!
  @IBOutlet weak var iconImage: WKInterfaceImage!
  @IBOutlet weak var descriptionLabel: WKInterfaceLabel!
  
  private var session: Session?
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)

    if let session = context as? Session {
      titleLabel.setText(session.title)
      descriptionLabel.setText(session.sessionDescription)
      if let trackImage = UIImage(named: session.track.name) {
        iconImage.setImage(trackImage)
      } else {
        iconImage.setHidden(true)
      }
      self.session = session
      configureContextMenu()
    }

    if let person = context as? Person {
      titleLabel.setText(person.fullName)
      descriptionLabel.setText(person.bio)
      if let avatar = UIImage(named: person.identifier) {
        iconImage.setImage(avatar)
      } else {
        iconImage.setHidden(true)
      }
    }
  }
  
  func configureContextMenu() {
    clearAllMenuItems()
    if let session = session {
      let favorite = session.isFavorite
      let icon: WKMenuItemIcon = favorite ? .Decline : .Add
      let title = favorite ? "Unfavorite" : "Favorite"
      addMenuItemWithItemIcon(icon, title: title, action: "toggleFavorite")
    }
  }
  
  func toggleFavorite() {
    if let session = session {
      session.isFavorite = !session.isFavorite
      configureContextMenu()
    }
  }
  
}
