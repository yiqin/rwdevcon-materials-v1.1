//
//  SpeakersViewController.swift
//  RWDevConCalendar
//
//  Created by Matt Galloway on 15/12/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit
import Social

class SpeakersViewController: UITableViewController {

  private var speakers = [(String, String)]()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.loadData()

    self.title = "Speakers"
  }

  private func loadData() {
    let path = NSBundle.mainBundle().pathForResource("speakers", ofType: "json")
    let jsonData = NSData(contentsOfFile: path!)
    let json = JSON(data: jsonData!)

    var speakers = [(String, String)]()

    for (key, value) in json {
      let speaker = (value["name"].stringValue, value["twitter"].stringValue)
      speakers.append(speaker)
    }

    speakers.sort {
      $0.0 < $1.0
    }

    self.speakers = speakers
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.speakers.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

    let speaker = self.speakers[indexPath.row]

    cell.textLabel?.text = speaker.0
    cell.detailTextLabel?.text = speaker.1

    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let speaker = self.speakers[indexPath.row]

    if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
      let viewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
      viewController.setInitialText("\(speaker.1) ")
      self.presentViewController(viewController, animated: true, completion: nil)
    }

    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

}
