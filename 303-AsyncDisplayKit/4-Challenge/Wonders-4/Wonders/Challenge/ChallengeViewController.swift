//
//  ChallengeViewController.swift
//  Wonders
//
//  Created by Rene Cacheaux on 1/28/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController, ASCollectionViewDataSource, ASCollectionViewDelegate {
  let collectionView = ASCollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
  let cards = allCards
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.asyncDataSource = self
    collectionView.asyncDelegate = self
    view.addSubview(collectionView)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    collectionView.frame = view.bounds
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:bottomLayoutGuide.length, right:0)
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let count = cards.count
    return count
  }
  
  func collectionView(collectionView: ASCollectionView!, nodeForItemAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {
    let card = cards[indexPath.item]
    let node = TallCardNode(card: card)
    return node
  }
  
  func collectionView(collectionView: ASCollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
    let card = cards[indexPath.item]
    let detailViewController = CardDetailViewController(card: card)
    detailViewController.modalPresentationStyle = .FullScreen
    detailViewController.modalTransitionStyle = .CrossDissolve
    presentViewController(detailViewController, animated: true, completion: nil)
  }
}
