//
//  Networking.swift
//  CourseCatalog
//
//  Created by Saul Mora on 1/3/15.
//  Copyright (c) 2015 Magical Panda. All rights reserved.
//

import Foundation
import Argo
import Runes

public enum Method: String { // Bluntly stolen from Alamofire
  case OPTIONS = "OPTIONS"
  case GET = "GET"
  case HEAD = "HEAD"
  case POST = "POST"
  case PUT = "PUT"
  case PATCH = "PATCH"
  case DELETE = "DELETE"
  case TRACE = "TRACE"
  case CONNECT = "CONNECT"
}

public struct Resource<A> {
  let path: String
  let method : Method
  let requestBody: NSData?
  let headers : [String:String]
  let parse: NSData -> A?
}

public enum Reason {
  case CouldNotParseJSON
  case NoData
  case NoSuccessStatusCode(statusCode: Int)
  case Other(NSError)
}

enum Result<T> {
  case Value(@autoclosure() -> T)
  case Error(NSError)
  
  init(_ value:T) {
    self = .Value(value)
  }
  
  init(_ error:NSError) {
    self = .Error(error)
  }
  
  var value : T? {
    switch self {
    case .Value(let value):
      return value()
    default:
      return nil
    }
  }
  
  var error : NSError? {
    switch self {
    case .Error(let error):
      return error
    default:
      return nil
    }
  }
}

func defaultFailureHandler(failureReason: Reason, data: NSData?) {
  let string = NSString(data: data!, encoding: NSUTF8StringEncoding)
  println("Failure: \(failureReason) \(string)")
}

public func apiRequest<A>(modifyRequest: NSMutableURLRequest -> (), baseURL: NSURL, resource: Resource<A>, failure: (Reason, NSData?) -> (), completion: A -> ()) {
  
  let session = NSURLSession.sharedSession()
  let url = baseURL.URLByAppendingPathComponent(resource.path)
  
  //build request
  let request = NSMutableURLRequest(URL: url)
  request.HTTPMethod = resource.method.rawValue
  request.HTTPBody = resource.requestBody
  modifyRequest(request)
  for (key,value) in resource.headers {
    request.setValue(value, forHTTPHeaderField: key)
  }
  
  //build task
  let task = session.dataTaskWithRequest(request){ (data, response, error) -> Void in
    //handle response
    if let httpResponse = response as? NSHTTPURLResponse {
      if httpResponse.statusCode == 200 {
        if let responseData = data {
          if let result = resource.parse(responseData) {
            completion(result)
          } else {
            failure(Reason.CouldNotParseJSON, data)
          }
        } else {
          failure(Reason.NoData, data)
        }
      } else {
        failure(Reason.NoSuccessStatusCode(statusCode: httpResponse.statusCode), data)
      }
    } else {
      failure(Reason.Other(error), data)
    }
  }
  task.resume()
}

func decodeJSON(data: NSData) -> JSONValue? {
  if let json: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: nil) {
    return JSONValue.parse(json)
  }
  return .None
}

func encodeJSON(json: JSONValue) -> NSData? {
  if let object = json.value() as [String:AnyObject]? {
    return NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.allZeros, error: nil)
  }
  return .None
}

public func jsonResource<A>(path: String, method: Method, requestParameters: JSONValue, parse: JSONValue -> A?) -> Resource<A> {
  let f = { decodeJSON($0) >>- parse }
  let jsonBody = encodeJSON(requestParameters)
  let headers = ["Content-Type": "application/json"]
  return Resource(path: path, method: method, requestBody: jsonBody, headers: headers, parse: f)
}
