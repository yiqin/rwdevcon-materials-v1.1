//
//  ConwayCocoa.swift
//  Life
//
//  Created by Alexis Gallagher on 2014-11-24.
//  Copyright (c) 2014 AlexisGallagher. All rights reserved.
//

import UIKit

class ConwayCocoa : NSObject
{
  /*
  @param coords coordinates for a cell
  @return array of neighboring cells
  */
  private class func neighbors(coords:NSDictionary) -> NSArray
  {
    let x = coords["x"] as NSNumber as Int
    let y = coords["y"] as NSNumber as Int
    
    let result = NSMutableArray()
    
    for dx in [-1,0,1] {
      let dyRange = (dx == 0) ? [-1,1] : [-1,0,1]
      for dy in dyRange {
        let newX = x + dx
        let newY = y + dy
        result.addObject(["x":newX,"y":newY])
      }
    }
    return NSArray(array: result)
  }
  
  class func activeCellsOneStepAfter(cells:NSSet) -> NSSet
  {
    let allNeighbors = NSMutableArray()
    for cell in cells.allObjects as [NSDictionary] {
      let neighbors = ConwayCocoa.neighbors(cell)
      allNeighbors.addObjectsFromArray(neighbors)
    }
    
    let freqs : NSDictionary = cocoa_frequencies(allNeighbors)
    
    let newCells = NSMutableSet()
    for possibleNewCell in freqs.allKeys as [NSDictionary]
    {
      let neighborCount : Int = freqs.objectForKey(possibleNewCell)!.integerValue
      if ( 3 == neighborCount ||
        (2 == neighborCount && cells.containsObject(possibleNewCell))) {
          newCells.addObject(possibleNewCell)
      }
    }
    
    return NSSet(set: newCells)
  }
  
}

