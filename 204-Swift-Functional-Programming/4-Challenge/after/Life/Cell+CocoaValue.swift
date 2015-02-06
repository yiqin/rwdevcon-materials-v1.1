//
//  Cell+CocoaValue.swift
//  Life
//
//  Created by Alexis Gallagher on 2014-11-25.
//  Copyright (c) 2014 AlexisGallagher. All rights reserved.
//

import Foundation


/// Immutable class representing a location on a grid
///
/// Note: This represents only a grid location, not the _state_ of that location
/// (i.e., active or inactive). To represent the overall state of
/// of a board, we use a collection containing only the active locations
final class CocoaCell : NSObject
{
  let x:Int
  let y:Int
  
  init(x:Int,y:Int) {
    self.x = x
    self.y = y
  }
}

/*

These extensions are required in order for Cell to behave as a value object
for use with Cocoa collections classes like NSSet, NSArray.

*/

// MARK: NSObjectProtocol

extension CocoaCell : NSObjectProtocol {
  override func isEqual(object: AnyObject?) -> Bool
  {
    if let otherCell = object as? CocoaCell {
      return self.x == otherCell.x && self.y == otherCell.y
    }
    else { return false }
  }
  
  override var hash : Int { return self.x.hashValue ^ self.y.hashValue }
}


// MARK: NSCopying

extension CocoaCell : NSCopying {
  /// Since this class is an immutable value object, object
  /// identity (===) is irrelevant and only value equality (==) has meaning.
  /// In this case, there is no need for the ability to create
  /// copies with distinct storage
  func copyWithZone(zone: NSZone) -> AnyObject {
    // As this class is immutable, object identity is moot.
    return self
  }
}


/*

This is a class-based, instead of struct-based, implemenation of Cell.

It shows an example of defining a value object in Cocoa.

Cocoa is not ideal for functional, value-oriented programming in some ways,
for instance, in the hassle of creating value objects.

Consider all the requirements to implement a class for representing value objects, which
can be smoothly used with the frameworks:

- boilerplate to initialize all members
- boilerplate to define equality based on the members
- possibly tricky boilerplate to define a hashing function
- a fairly subtle understanding of the interaction between immutable value semantics and storage management, in order to implement NSCopying

It is regrettable that it takes 50+ LOC to produce a class which only contains two integers,
which can be used conveniently with the framework's collection types.

There are many functional styles. But from the Clojure point of view, this is one reason to
dispense with custom data types in most cases and just use dictionaries. You have the hassle
of boxing and unboxing, but out of the box they give you equality, hashing, a literal
representation, and a variety of general purpose accessors.

The folder group "unused_CocoaStyle" shows an alternative implementation in this style,
using Cocoa collections and NSDictionary.

*/

