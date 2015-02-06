//
//  PhotoTableViewCell.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 12/1/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import UIKit

class PhotoTableViewCell : UITableViewCell {
  @IBOutlet var photoImageView : UIImageView!
  @IBOutlet var titleLabel : UILabel!
  @IBOutlet var userNameLabel : UILabel!
  @IBOutlet var favoriteIcon: UIImageView!
  
  class func cellIdentifier() -> String {
    return flk_className()
  }
  
  override func prepareForReuse() {
    photoImageView.image = nil
  }
}