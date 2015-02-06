// Playground - noun: a place where people can play

import UIKit

// First we show the beginnings of an intuitive but not
// particularly "functional programming" way to model
// Conway's Game of Life.

// Conway's Game of Life takes place over a 2D grid,
// which changes over time as cells live and die.
// So we represent the grid as a board, a 10x10 2D array
// of Boolean values.

struct Cell
{
  let x:Int
  let y:Int
}

// MARK: Equatable
/// Two cells are equal iff all their members are equal
func ==(lhs: Cell, rhs: Cell) -> Bool {
  return lhs.x == rhs.x && lhs.y == rhs.y
}

// MARK: Hashable
extension Cell : Hashable {
  var hashValue : Int { return self.x.hashValue ^ self.y.hashValue  }
}

let initialBoard = [Cell(x:0,y:0)]


func neighbors(OfCell cell:Cell) -> [Cell]
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

/// compute next cells, using no HOFs
func activeCellsOneStepAfter(activeCells:[Cell]) -> [Cell]
{
  // STAGE 1. loop to build array of every "neighboring", an instance of a living cell being neighbored
  // i.e., "map" every active cell to an array of its neighbors, then concatante the arrays.
  var neighborings = [Cell]()
  for cell in activeCells {
    for neighborOfCell in neighbors(OfCell: cell) {
      neighborings.append(neighborOfCell)
    }
  }
  
  // STAGE 2. loop and count duplicate neighborings
  // i.e. "reduce" an array of Cells to an array of (Cell,Int) tuples counting duplicates
  var neighboringsPerCell = Dictionary<Cell,Int>()
  for neighboringCell in neighborings {
    if let value = neighboringsPerCell[neighboringCell] {
      neighboringsPerCell[neighboringCell] = value + 1
    }
    else {
      neighboringsPerCell[neighboringCell] = 1
    }
  }
  
  // STAGE 3. loop to filter only neighborings with certain counts
  // filter an array of (Cell,Int) tuples based on the Int value and other conditions
  let neighboringsPerCellActiveNextStep = filter(neighboringsPerCell,
    { (theNeighbor:Cell,neighborCount:Int) -> Bool in
      return (neighborCount == 3) || (neighborCount == 2 && find(activeCells,theNeighbor) != nil)
  })

  // STAGE 4. loop to gather only the neighborings themselves
  // map an array of (Cell,Int) tuples to an array of Cells
  var neighboringsActiveNextStep = [Cell]()
  for (theNeighbor,neighborCount) in neighboringsPerCellActiveNextStep {
      neighboringsActiveNextStep.append(theNeighbor)
  }
  
  // result: the cells alive at the next step in time
  return neighboringsActiveNextStep
}




