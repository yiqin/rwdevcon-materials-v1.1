//
//  NSStringExtension.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 12/9/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import UIKit

extension NSString {
  
  class func flk_pathToDocumentsDirectory() -> String {
    return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last as String
  }
  
  /**
  Grabs the path of a sub-directory of the documents directory, creating it if needed.
  
  :param: subdirectoryName The name of the sub-directory
  :returns: The path of the existing or created sub-directory.
  */
  public class func flk_createdDocumentsSubdirectory(subdirectoryName: String) -> String {
    let docs = flk_pathToDocumentsDirectory()
    let subdirectory = docs.stringByAppendingPathComponent(subdirectoryName)
    
    subdirectory.flk_createDirectoryIfNeeded()
    
    return subdirectory
  }
  
  func flk_createDirectoryIfNeeded() {
    if !NSFileManager.defaultManager().fileExistsAtPath(self) {
      var error: NSError?
      NSFileManager.defaultManager().createDirectoryAtPath(self,
        withIntermediateDirectories: true,
        attributes: nil,
        error: &error)
      
      if let unwrappedError = error {
        NSLog("Error creating directory \(self): \(unwrappedError)")
      }
    } //else it already exists.
  }
}
