//
//  Cell.swift
//  Life
//
//  Created by Alexis Gallagher on 2014-11-24.
//  Copyright (c) 2014 AlexisGallagher. All rights reserved.
//

import Foundation

/// Immutable struct representing a location on a grid
///
/// Note: This represents only a grid location, not the _state_ of that location
/// (i.e., active or inactive). To represent the overall state of
/// of a board, we use a collection containing only the active locations
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


/*

# Notes

### value object

This defines an immutable struct representing a point.

Because it is immutable, it acts as a value object. A value object is an object like NSNumber
or NSString, immutable and equal to its peers based on its contents (its value), with no meaningful 
notion of equality based on object identity (i.e, storage location). A value object lets you write 
functions as if they are consuming and returning mathematical values, not memory locations.

### struct vs class, and immutability

Why use a struct instead of a class?

The only benefit of a struct here is the trivial benefit that it provides a convenience
initializer by default.

Given that we want a value object, we must make this immutable. Given that it is immutable,
a class or a struct serves equally well.

Why? This is because the essential difference between a class and a struct is that
a class is a reference type and a struct is a value type. Since a class is a reference
type, it is subject to _aliasing_, meaning that one object can have multiple
owners referring to it. But aliasing is only visible in the presence of mutation, i.e., where one 
owner makes changes that surprise another.

So if you define your type to be immutable, with value-based equality, 
then aliasing is irrelevant, and the distinction between a struct and class
is in fact invisible (except for effects on storage usage).

*/


