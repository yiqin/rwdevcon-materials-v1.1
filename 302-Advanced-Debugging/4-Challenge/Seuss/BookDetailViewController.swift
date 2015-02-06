//
//  BookDetailViewController.swift
//  Seuss
//
//  Created by Richard Turton on 04/01/2015.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var book : Book? = nil
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = book?.title
        imageView.image = book?.image
        ratingLabel.text = book?.ratingString ?? "No rating"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
