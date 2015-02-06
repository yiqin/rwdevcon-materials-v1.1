//
//  Conway.swift
//  Life
//
//  Created by Alexis Gallagher on 2014-11-23.
//  Copyright (c) 2014 AlexisGallagher. All rights reserved.
//

import UIKit


/**

Returns the cells active in the next time step. (pure)

:param: activeCells cells active currently
:returns: array of cells active in the next moment

*/
func activeCellsOneStepAfter(activeCells:[Cell]) -> [Cell]
{
  // STAGE 1. loop to build array of every "neighboring", an instance of a living cell being neighbored
  // i.e., "map" every active cell to an array of its neighbors, then concatante the arrays.
  let neighborings = mapcat(activeCells, neighbors)
  
  // STAGE 2. loop and count duplicate neighborings
  // i.e. "reduce" an array of Cells to an array of (Cell,Int) tuples counting duplicates
  var neighboringsPerCell = frequencies(neighborings)
  
  // STAGE 3. loop to filter only neighborings with certain counts
  // filter an array of (Cell,Int) tuples based on the Int value and other conditions
  let neighboringsPerCellActiveNextStep = filter(neighboringsPerCell,
    { (theNeighbor:Cell,neighborCount:Int) -> Bool in
      return (neighborCount == 3) || (neighborCount == 2 && find(activeCells,theNeighbor) != nil)
  })
  
  // STAGE 4. loop to gather only the neighborings themselves
  // map an array of (Cell,Int) tuples to an array of Cells
  let neighboringsActiveNextStep = map(neighboringsPerCellActiveNextStep, { (theNeighbor:Cell,_) -> Cell in return theNeighbor} )
  
  // result: the cells alive at the next step in time
  return neighboringsActiveNextStep
}

/**
Returns all cells neighboring a cell. (Pure)

:param: cell a cell
:returns: array of neighboring cells
*/
private func neighbors(OfCell cell:Cell) -> [Cell]
{
  let deltas = [(-1,-1),(0,-1),(1,-1),
    (-1, 0),       (1,0 ),
    (-1, 1),(0, 1),(1, 1)]
  
  let neighbors = map(deltas,{
    (delta:(Int,Int)) -> Cell in
    return Cell(x: cell.x + delta.0, y: cell.y + delta.1)
  })
  return neighbors
}


