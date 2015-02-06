// Playground - noun: a place where people can play

import UIKit

// STEP 1 - Variables, strings, string interpolation

let conference: String = "RWDevCon"
//conference = "WWDC" /* Can only do this if `conference` is `var` */
println("The best conference is \(conference)")





// STEP 2 - Collections, optionals, tuples

var animals: [String] = ["Dog", "Cat", "Mouse", "Horse"]

animals.append("Cow")

//animals.append(123) /* Doesn't work because `animals` is an array of `String`s */

for animal: String in animals {
  println(animal)
}

var nonOptionalString: String = "Dogs Are Fun"
//nonOptionalString = nil /* Doesn't work because `nonOptionalString` must be a `String` */

var optionalString: String? = "Dogs Are Fun"
optionalString = nil

let farmAnimals: [String:Int] = ["Dog":2, "Cat":0, "Cow":100]

let animal: String = "Mouse"
let numberOfAnimal: Int? = farmAnimals[animal]

println("I have \(numberOfAnimal) \(animal)s")

if numberOfAnimal != nil {
  println("I have \(numberOfAnimal!) \(animal)s")
}

if let numberOfAnimal: Int = farmAnimals[animal] {
  println("I have \(numberOfAnimal) \(animal)s")
}

let tuple: (String, Int) = ("RWDevCon", 180)
println("\(tuple.0), \(tuple.1)")

let namedTuple: (foo: String, bar: Int) = ("RWDevCon", 180)
println("\(namedTuple.foo), \(namedTuple.bar)")

for (key: String, value: Int) in farmAnimals {
  println("\(key) => \(value)")
}




// STEP 3 - Introducing Tic Tac Toe

enum Player {
  case X
  case O
}

struct Position: Hashable {
  var column: Int
  var row: Int

  func asString() -> String {
    return "\(column):\(row)"
  }

  var hashValue: Int {
    return column * 10 + row
  }
}

func ==(lhs: Position, rhs: Position) -> Bool {
  return lhs.column == rhs.column && lhs.row == rhs.row
}

var pos1 = Position(column: 0, row: 0)
var pos2 = pos1

pos1.column = 1
println(pos1.column)
println(pos2.column)

println(pos1.asString())

if pos1 == pos2 {
  println("They're equal")
} else {
  println("They're not equal")
}

var turns: [Position:Player] = [:]

turns[pos1] = Player.X
turns[pos2] = .O
