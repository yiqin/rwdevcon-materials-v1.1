//
//  ViewController.swift
//  Life
//
//  Created by Alexis Gallagher on 2014-11-23.
//  Copyright (c) 2014 AlexisGallagher. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
  private var timer:NSTimer?

  @IBOutlet weak var gridView: GridView!
  @IBOutlet weak var playPauseButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    let glider = [
      Cell(x: 0, y: 2),
      Cell(x: 1, y: 2),
      Cell(x: 2, y: 2),
      Cell(x: 2, y: 1),
      Cell(x: 1, y: 0),
    ]
    
    self.gridView.activeCoords = glider
  }

  // progresses board state by one step
  @IBAction func stepButtonTapped(sender: AnyObject) {
    let oldState = self.gridView.activeCoords
    let newState = activeCellsOneStepAfter(oldState)  // <- the action happens here, baby!
    self.gridView.activeCoords = newState
    self.gridView.setNeedsDisplay()
  }
  
  // plays/pauses time
  @IBAction func playpauseButtonTapped(sender: AnyObject) {
    if let timer = self.timer {
      timer.invalidate()
      self.timer = nil
    }
    else {
      self.timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.5), target: self, selector: Selector("stepButtonTapped:"), userInfo: nil, repeats: true)
    }
    self.updatePlayPauseButtonTitle()
  }
  
  func updatePlayPauseButtonTitle() {
    /* 
    (The nil-coalescing operator ?? and the tertiary conditional operator ?:
    are both typically functional in that they define expressions (not a statment),
    so they return values which can be treated as immutable constants.)
    */
    let isTimerRunning = self.timer?.valid ?? false
    let title = isTimerRunning ? "Pause" : "Play"
    self.playPauseButton.setTitle(title, forState: .Normal)
  }
}
