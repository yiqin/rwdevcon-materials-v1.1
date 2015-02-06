// Playground - noun: a place where people can play

import Swift
import Foundation

func countOccurrences(value: Int, array: [Int]) -> String {
  var count = 0
  for element in array {
    if element == value {
      ++count
    }
  }
  return "\(value) appears \(count) times"
}

let myArray = [100, 28, 999, 43, 62, 999, 77, 35, 999, 999, 123]

countOccurrences(999, myArray)

/* ------------------------------------------------------------ */

class MyClass {
  private var array: [Int]
  
  init(array: [Int]) {
    self.array = array
  }
}

let myObject = MyClass(array: myArray)

/* ------------------------------------------------------------ */

enum Player {
  case X
  case O
}
