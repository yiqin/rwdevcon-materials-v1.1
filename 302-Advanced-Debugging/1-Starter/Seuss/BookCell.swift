//
//  BookCell.swift
//  Seuss
//
//  Created by Richard Turton on 19/11/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
  
  @IBOutlet weak var coverImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var bottomContentView: UIView!
  @IBOutlet weak var reviewField: UITextField!
  @IBOutlet weak var ratingLabel: UILabel!
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    let animation = {
      self.bottomContentView.alpha = selected ? 1.0 : 0.0
    }
    
    if animated {
      UIView.animateWithDuration(0.33, delay: selected ? 0.33 : 0.0, options: .CurveEaseOut, animations: animation, completion: nil)
    } else {
      animation()
    }
  }
}
