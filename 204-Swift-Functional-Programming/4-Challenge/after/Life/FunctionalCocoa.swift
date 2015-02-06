//
//  FunctionalCocoa.swift
//  Life
//
//  Created by Alexis Gallagher on 2014-11-24.
//  Copyright (c) 2014 AlexisGallagher. All rights reserved.
//

import Foundation

/**
Calculates frequencies of of values in `items`

:param: items an array of values implementing NSCopying

:returns: NSDictionary with frequences of items
*/
func cocoa_frequencies(coll:NSArray) -> NSDictionary
{
  let d = NSMutableDictionary()
  for obj in coll as [NSCopying] {
    if d.objectForKey(obj) == nil {
      d.setObject(0, forKey: obj)
    }
    d.setObject(1 + d.objectForKey(obj)!.integerValue, forKey: obj)
  }
  return NSDictionary(dictionary: d)
}

