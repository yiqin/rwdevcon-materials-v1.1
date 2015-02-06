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
  var stories:[Array<Story>]!
  var categoryNames:[String]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    var zombieStories = [Story]()
    var vampireStories = [Story]()
    var alienStories = [Story]()
    stories = [Array<Story>]()
    title = "Story Time!"
    
    var zombieWinStory = "<name> entered the room and saw <number> <monsters>! <name> ran down the hall. Sadly, <name> was <verb> by all the <monsters>! \n\nPoor <name>. Better luck next time!"
    var zombieLoseStory = "<name> entered the room and saw <number> <monsters>! Without missing a beat, <name> <verb> all of the <monsters>! \n\nPoor <monsters>. Fantastic! \n\n<name> will live to fight another day."
    var vampireWinStory = "<name> entered the room and saw <number> <monsters>! <name> ran down the hall. Sadly, <name> was <verb> by all the <monsters>! \n\nPoor <name>. Better luck next time!"
    var vampireLoseStory = "<name> entered the room and saw <number> <monsters>! Without missing a beat, <name> <verb> all of the <monsters>! \n\nPoor <monsters>. Fantastic! \n\n<name> will live to fight another day."
    
    var alienWinStory = "<name> entered the room and saw <number> <monsters>! <name> ran down the hall. Sadly, <name> was <verb> by all the <monsters>! \n\nPoor <name>. Better luck next time!"
    var alienLoseStory = "<name> entered the room and saw <number> <monsters>! Without missing a beat, <name> <verb> all of the <monsters>! \n\nPoor <monsters>. Fantastic! \n\n<name> will live to fight another day."
    
    let zombieStory = Story(title: "Attack of the Zombies", winStory: zombieWinStory, loseStory: zombieLoseStory, type: StoryType.zombies)
    let vampireStory = Story(title: "Attack of the Vampires!", winStory: vampireWinStory, loseStory: vampireLoseStory, type: StoryType.vampires)
    var alienStory = Story(title: "Attack of the Aliens", winStory: alienWinStory, loseStory: alienLoseStory, type: StoryType.aliens)
    
    categoryNames = [String]()
    categoryNames.append("Zombie Stories")
    categoryNames.append("Vampire Stories")
    categoryNames.append("Alien Stories")
    
    zombieStories.append(zombieStory)
    vampireStories.append(vampireStory)
    alienStories.append(alienStory)
    stories.append(zombieStories)
    stories.append(vampireStories)
    stories.append(alienStories)
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return stories.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return stories[section].count
  }
  
  @IBAction func close(segue:UIStoryboardSegue) {
    let newStoryViewController = segue.sourceViewController as NewStoryViewController
    if !newStoryViewController.didCancel {
      if let story = newStoryViewController.newStory {
        stories[story.type.rawValue].append(story)
        tableView.reloadData()
      }
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "GenerateStory" {
      if let indexPath = tableView.indexPathForSelectedRow() {
        let storyViewController = segue.destinationViewController as ViewController
        storyViewController.currentStory = stories[indexPath.section][indexPath.row]
      }
    }
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return categoryNames[section]
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("StoryTimeCell", forIndexPath: indexPath) as UITableViewCell
    var story: Story!
    story = stories[indexPath.section][indexPath.row]
    cell.textLabel?.text = story.title
    return cell
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
