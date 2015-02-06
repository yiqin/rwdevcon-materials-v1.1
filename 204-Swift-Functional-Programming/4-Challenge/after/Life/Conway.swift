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

style: uses HOFs
*/
func activeCellsOneStepAfter(activeCells:[Cell]) -> [Cell]
{
  /*
  Every cell in `neighborings` represents an instance of that cell
  being neighbored by one of the active cells. Since a cell can be neighbored
  on many sides, we expect duplicates
  */
  let neighborings : [Cell] = mapcat(activeCells, neighbors)
  
  /*
  This dictionary counts how many times each cell is neighbored
  by an active cell
  */
  let neighboringsPerCell = frequencies(neighborings)
  
  /*
  A cell is active at the next moment iff:
  - it has three neighbors in this moment
  - it has two neighbors in this moment, and is active in this moment
  */
  
  func isActiveNextStep(cell:Cell, neighboringCount:Int) -> Bool
  {
    return
      (neighboringCount == 3) ||
        (neighboringCount == 2 && find(activeCells,cell) != nil)
  }
  
  let neighboringsActiveNextStep:[(Cell,Int)] = filter(neighboringsPerCell, isActiveNextStep )
  let cellsActiveNextStep = map(neighboringsActiveNextStep, { ($0).0 } )
  return cellsActiveNextStep
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

  return map(deltas, { Cell(x: cell.x + $0.0, y: cell.y + $0.1) } )
}
