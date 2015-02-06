//
//  LabViewController.swift
//  Wonders
//
//  Created by Rene Cacheaux on 1/28/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class LabViewController: UIViewController, ASCollectionViewDataSource, ASCollectionViewDelegate {
  let collectionView = ASCollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
  let cards = allCards
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.asyncDataSource = self
    collectionView.asyncDelegate = self
    collectionView.rangeTuningParameters = ASRangeTuningParameters(leadingBufferScreenfuls: 0.5, trailingBufferScreenfuls: 0.5)
    view.addSubview(collectionView)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:bottomLayoutGuide.length, right:0)
    collectionView.frame = view.bounds
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let count = cards.count
    return count
  }
  
  func collectionView(collectionView: ASCollectionView!, nodeForItemAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {
    let card = cards[indexPath.item]
    let node = CardNode(card: card)
    return node
  }
}
