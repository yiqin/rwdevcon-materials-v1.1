// Playground - noun: a place where people can play

import Swift
import Foundation

func countOccurrences<T: Equatable>(value: T, array: Array<T>) -> String {
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

let stringArray = ["A", "B", "C", "B", "D", "E"]

countOccurrences("B", stringArray)

/* ------------------------------------------------------------ */

typealias TransformArray = (Int, Array<Int>) -> String

class MyClass {
  private var array: [Int]
  
  init(array: [Int]) {
    self.array = array
  }

  func countOccurrences(value: Int) -> String {
    var count = 0
    for element in array {
      if element == value {
        ++count
      }
    }
    return "\(value) appears \(count) times"
  }

  func performClosure(value: Int, closure: TransformArray) -> String {
    return closure(value, array)
  }
}

let myObject = MyClass(array: myArray)

myObject.countOccurrences(999)

let c: TransformArray = { (value: Int, array: [Int]) -> String in
  var count = 0
  for element in array {
    if element == value {
      ++count
    }
  }
  return "\(value) appears \(count) times"
}

c(999, myArray)

myObject.performClosure(999, closure: c)

myObject.performClosure(100) { value, array in
  var newArray = [Int]()
  for element in array {
    newArray.append(element + value)
  }
  return newArray.description
}

/* ------------------------------------------------------------ */

enum Player {
  case X(username: String, country: String)
  case O
}

let p = Player.X(username: "Steve", country: "USA")

let t = Player.X(username: "Tim", country: "Belgium")

switch t {
case let .X(_, country):
  println(country)
case .O:
  println("Player is O")
}

var s1: String? = "Not nil"
var s2: Optional<String> = .Some("Not nil")
s1 == s2
