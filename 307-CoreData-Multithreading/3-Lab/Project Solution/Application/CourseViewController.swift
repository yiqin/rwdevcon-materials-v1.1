//
//  DetailViewController.swift
//  CourseCatalog
//
//  Created by Saul Mora on 12/6/14.
//  Copyright (c) 2014 Magical Panda. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController {
  
  @IBOutlet weak var courseNameLabel: UILabel!
  @IBOutlet weak var courseDescriptionLabel: UILabel!
  @IBOutlet weak var courseImageView: UIImageView!
  
  var course: Course?
}

