//
//  UITableViewExtension.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 12/9/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import UIKit

extension UITableView {
  
  /**
  :returns: An array of the NSIndexPaths of the visible cells, or nil if no cells are visible.
  */
  func flk_visibleIndexPaths() -> [NSIndexPath]? {
    let cells = self.visibleCells()
    
    if cells.count == 0 {
      return nil
    } else {
      var indexPaths = [NSIndexPath]()
      for cell in cells {
        let indexPath = self.indexPathForCell(cell as UITableViewCell)
        if let unwrappedIndexPath = indexPath {
          indexPaths.append(unwrappedIndexPath)
        }
      }
      
      return indexPaths
    }
  }
}
