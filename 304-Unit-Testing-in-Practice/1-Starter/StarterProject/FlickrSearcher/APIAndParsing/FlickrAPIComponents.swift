//
//  FlickrAPIComponents.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 11/15/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import Foundation

/**
Helper class to abstract out creating URLs to call the Flickr API.
*/
class FlickrAPIComponents {
  
  let BasePath = "/services/rest/"
  let urlComponents = NSURLComponents(string: "https://api.flickr.com")
  
  /**
  Constructor of Flickr API calls.
  
  :param: params Any parameters to add as an array of NSURLQueryItems, or nil if there are no other parameters to add
  :returns: The constructed URL, or nil if an error occurred.
  */
  func urlWithParams(var params: [NSURLQueryItem]?) -> NSURL? {
    if let components = urlComponents {
      //Setup the path
      components.path = BasePath
      
      
      //Setup the stock query items
      let apiKeyQueryItem = NSURLQueryItem(name: FlickrParameterName.APIKey.rawValue, value: FlickrAuthCredential.APIKey.rawValue)
      let formatQueryItem = NSURLQueryItem(name: FlickrParameterName.Format.rawValue, value: FlickrParameterValue.Format.rawValue)
      let cleanJSONQueryItem = NSURLQueryItem(name: FlickrParameterName.CleanJSON.rawValue, value: FlickrParameterValue.CleanJSON.rawValue)
      
      var queryItems = [NSURLQueryItem]()
      queryItems.append(apiKeyQueryItem)
      queryItems.append(formatQueryItem)
      queryItems.append(cleanJSONQueryItem)
      
      //Add any passed in parameters
      if let passedInParams = params {
        for param in passedInParams {
          queryItems.append(param)
        }
      }
      
      components.queryItems = queryItems
      return components.URL
    } else {
      return nil
    }
  }
}