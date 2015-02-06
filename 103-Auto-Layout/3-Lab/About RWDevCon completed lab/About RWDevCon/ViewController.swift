/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var beginnerView: UIView!
  @IBOutlet weak var intermediateView: UIView!
  @IBOutlet weak var advancedView: UIView!

  @IBOutlet weak var beginnerButton: UIButton!
  @IBOutlet weak var intermediateButton: UIButton!
  @IBOutlet weak var advancedButton: UIButton!

  var advancedLabel: UILabel!
  var intermediateLabel: UILabel!

  var advancedVerticalConstraint: NSLayoutConstraint!

  let verticalMargin: CGFloat = 8.0

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func detailsButtonTapped(sender: UIButton) {
    if advancedLabel == nil {
      addAdvancedLabel()
      addIntermediateLabel()
    } else {
      toggleLabel()
    }
  }

  private func toggleLabel() {
    if intermediateLabel.alpha == 0 {
    intermediateLabel.alpha = 1
    advancedVerticalConstraint.constant = verticalMargin
  } else {
    intermediateLabel.alpha = 0
    advancedVerticalConstraint.constant =
    CGRectGetHeight(advancedView.frame)
    }
  }

  private func addIntermediateLabel() {
    intermediateLabel = UILabel()
    intermediateLabel.setTranslatesAutoresizingMaskIntoConstraints(
      false)
    intermediateLabel.text = "This track is for Objective-C developers who are not yet fully up-to-speed with Swift."
    intermediateLabel.numberOfLines = 0
    intermediateView.addSubview(intermediateLabel)

    // 1
    let views = ["intermediateLabel": intermediateLabel,
      "intermediateView": intermediateView,
      "intermediateButton": intermediateButton]
    let metrics = ["margin": 4, "verticalMargin": verticalMargin]

    // 2
    let horizontalConstraints =
    NSLayoutConstraint.constraintsWithVisualFormat(
      "H:|-margin-[intermediateLabel]-margin-|",
      options: nil, metrics: metrics, views: views)
    // 3
    let verticalConstraints =
    NSLayoutConstraint.constraintsWithVisualFormat(
      "V:[intermediateButton]-verticalMargin-[intermediateLabel]",
      options: nil, metrics: metrics, views: views)

    // 4
    NSLayoutConstraint.activateConstraints(horizontalConstraints + verticalConstraints)
  }

  private func addAdvancedLabel() {
    // 1
    advancedLabel = UILabel()
    advancedLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
    advancedLabel.text = "Dive deep into a guided tour of more advanced topics like functional programming, Scene Kit, and more!"
    advancedLabel.numberOfLines = 0
    advancedView.addSubview(advancedLabel)

    // 2
    advancedVerticalConstraint = NSLayoutConstraint(
      item: advancedLabel,
      attribute: .Top,
      relatedBy: .Equal,
      toItem: advancedButton,
      attribute: .Bottom,
      multiplier: 1.0,
      constant: verticalMargin)
    advancedVerticalConstraint.active = true

    // 3
    let leadingConstraint = NSLayoutConstraint(
      item: advancedLabel,
      attribute: .Leading,
      relatedBy: .Equal,
      toItem: advancedView,
      attribute: .LeadingMargin,
      multiplier: 1.0,
      constant: 0)
    leadingConstraint.active = true

    // 4
    let trailingConstraint = NSLayoutConstraint(
      item: advancedLabel,
      attribute: .Trailing,
      relatedBy: .Equal,
      toItem: advancedView,
      attribute: .TrailingMargin,
      multiplier: 1.0,
      constant: 0)
    trailingConstraint.active = true
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
