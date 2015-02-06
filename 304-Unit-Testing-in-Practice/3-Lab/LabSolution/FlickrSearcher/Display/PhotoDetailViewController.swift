//
//  PhotoDetailViewController.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 12/2/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import UIKit

class PhotoDetailViewController : UIViewController {
  
  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var userNameLabel: UILabel!
  @IBOutlet var userAvatarImageView: UIImageView!
  @IBOutlet var favoriteButton: UIButton!
  
  var downloader = FlickrPhotoDownloader.sharedInstance()
  
  var photo : Photo?
  
  //MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if ShouldUseFakeDataInApplication {
      downloader = MockPhotoDownloader.sharedInstance()
    }
    
    //Circleify the avatar image view
    userAvatarImageView.layer.cornerRadius = CGRectGetWidth(userAvatarImageView.frame) / 2
    userAvatarImageView.layer.borderWidth = 1
    userAvatarImageView.layer.borderColor = UIColor.blackColor().CGColor
    
    if let unwrappedPhoto = photo {
      configureForPhoto(unwrappedPhoto)
    }
  }
  
  deinit {
    //Nuke setting anything to these image views.
    downloader.cancelSetToImageView(photoImageView)
    downloader.cancelSetToImageView(userAvatarImageView)
  }
  
  //MARK: Setup Helpers
  
  func configureForPhoto(aPhoto: Photo) {
    titleLabel.text = aPhoto.title
    downloader.setImageFromURLString(aPhoto.fullURLString, toImageView: photoImageView)
    userNameLabel.text = aPhoto.owner.name ?? aPhoto.owner.userID
    
    if let iconString = aPhoto.owner.iconURLString {
      downloader.setImageFromURLString(iconString, toImageView: userAvatarImageView)
    } else {
      //Use placeholder.
      userAvatarImageView.image = UIImage(named: "rwdevcon-logo")
    }
    
    
    configureFavoriteButtonColorBasedOnPhoto(aPhoto)
  }
  
  func configureFavoriteButtonColorBasedOnPhoto(aPhoto: Photo) {
    if aPhoto.isFavorite {
      favoriteButton.tintColor = UIColor.redColor()
    } else {
      favoriteButton.tintColor = UIColor.lightGrayColor()
    }
  }
  
  @IBAction func toggleFavoriteStatus() {
    if let unwrappedPhoto = photo {
      unwrappedPhoto.isFavorite = !unwrappedPhoto.isFavorite
      CoreDataStack.sharedInstance().saveMainContext()
      configureFavoriteButtonColorBasedOnPhoto(unwrappedPhoto)
    }
  }
}
