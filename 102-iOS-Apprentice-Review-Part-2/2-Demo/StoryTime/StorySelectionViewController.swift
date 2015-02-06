//
//  StorySelectionViewController.swift
//  StoryTime
//
//  Created by Brian Moakley on 1/30/15.
//  Copyright (c) 2015 Tammy Coron. All rights reserved.
//

import UIKit

class StorySelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  var zombieStories:[Story]!
  var vampireStories:[Story]!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        zombieStories = [Story]()
        vampireStories = [Story]()
        title = "Story Time!"
      
      var zombieWinStory = "<name> entered the room and saw <number> <monsters>! <name> ran down the hall. Sadly, <name> was <verb> by all the <monsters>! \n\nPoor <name>. Better luck next time!"
      var zombieLoseStory = "<name> entered the room and saw <number> <monsters>! Without missing a beat, <name> <verb> all of the <monsters>! \n\nPoor <monsters>. Fantastic! \n\n<name> will live to fight another day."
      var vampireWinStory = "<name> entered the room and saw <number> <monsters>! <name> ran down the hall. Sadly, <name> was <verb> by all the <monsters>! \n\nPoor <name>. Better luck next time!"
      var vampireLoseStory = "<name> entered the room and saw <number> <monsters>! Without missing a beat, <name> <verb> all of the <monsters>! \n\nPoor <monsters>. Fantastic! \n\n<name> will live to fight another day."
      
      let zombieStory = Story(title: "Attack of the Zombies", winStory: zombieWinStory, loseStory: zombieLoseStory, type: StoryType.zombies)
      
      let vampireStory = Story(title: "Attack of the Vampires!", winStory: vampireWinStory, loseStory: vampireLoseStory, type: StoryType.vampires)
      
      zombieStories.append(zombieStory)
      vampireStories.append(vampireStory)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch(section) {
    case 0:
      return zombieStories.count
    case 1:
      return vampireStories.count
    default:
      return 0
    }
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("StoryTimeCell", forIndexPath: indexPath) as UITableViewCell
    var story: Story!
    if indexPath.section == 0 {
      story = zombieStories[indexPath.row] as Story
    } else {
      story = vampireStories[indexPath.row] as Story
    }
    cell.textLabel?.text = story.title
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "GenerateStory" {
      if let indexPath = tableView.indexPathForSelectedRow() {
        let storyViewController = segue.destinationViewController as ViewController
        if indexPath.section == 0 {
          storyViewController.currentStory = zombieStories[indexPath.row] as Story
        } else {
          storyViewController.currentStory = vampireStories[indexPath.row] as Story
        }
      }
    }
  }
  

}
