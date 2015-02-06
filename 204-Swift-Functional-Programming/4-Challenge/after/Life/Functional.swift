//
//  Functional.swift
//  Life
//
//  Created by Alexis Gallagher on 2014-11-24.
//  Copyright (c) 2014 AlexisGallagher. All rights reserved.
//

import Foundation

// MARK: mapcat

/**
Returns the results of concatenating the arrays produced by transforming every element in source. (Called concatMap in Haskell, mapcat in Clojure)

:param: source sequence of elements, to be transformed
:param: transform function taking an element of source element to an array of `T`
:returns: Array<T>
*/
func mapcat<S : SequenceType, T>(source:S, transform: (S.Generator.Element) -> [T]) -> [T]
{
  let groups:[[T]] = map(source, transform)
  return reduce(groups, [T](), +)
}

// MARK: frequency

/**
Calculates frequencies of of values in `items`

:param: items a collection of values

:returns: Dictionary with frequencies of items
*/
func frequencies<T : Hashable>(coll:[T]) -> Dictionary<T,Int>
{
  return reduce(coll, [T:Int](), { (currentFreqs:[T:Int], item:T) -> [T:Int] in
    var updatedFreqs = currentFreqs
    updatedFreqs[item] = 1 + (updatedFreqs[item] ?? 0)
    return updatedFreqs
  })
}

//
// unused
//

/**

Returns an array stripped of duplicates, without preserving order.

:param: items an array
:returns: an array, stripped of duplicates, with order possibly changed
*/
func nub<T:Hashable>(items:[T]) -> [T]
{
  var dict = Dictionary<T,Bool>()
  items.map({ dict.updateValue(true, forKey: $0) })
  return Array(dict.keys)
}

// MARK: merge

/// Returns a Dictionary formed by updating `d` with
/// all elements in d2
private func mergeDictionairyPair<T,U>(var d:[T:U],d2:[T:U]) ->[T:U]
{
  for (k,v) in d2 {   d.updateValue(v, forKey: k)   }
  return d
}

private func mergeDictionaryArray<T,U>(dictionaries:[[T:U]]) -> [T:U]
{
  return reduce(dictionaries,[T:U](),mergeDictionairyPair)
}

func merge<T,U>(dictionaries:[T:U]...) -> [T:U] {
  return mergeDictionaryArray(dictionaries)
}

//
// for the curious
//

/**
In Haskell, for instance, `reduce` is called foldl, for "fold left", and it is defined as a curried function.

:param: combine reducing function
:param: initial initial value of the result type
:param: items array of items to reduce

*/
func foldl<A,B>(#combine:(B,A)->B)(initial:B)(items:[A]) -> B
{
  return reduce(items,initial,combine)
}

/*
Because it is defined in curried form,
you can use partial application to define
functions based on foldl.

This sort of idiom is more natural in Haskell,
where is is supported by various language
features -- i.e., all functions are curried by default,
compiler tail-call elimination which allows recursion with
only constant storage, and a syntax which privileges 
function application
*/
let mySum = foldl(combine:+)(initial: 0)
let calculatedTotal = mySum(items: [5,6,7]) // => 18

let myProduct = foldl(combine:*)(initial:1)
let calculatedProduct = myProduct(items: [5,6,7]) // => 210





