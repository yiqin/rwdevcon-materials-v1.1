//
//  FlickrAPIController.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 11/14/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import UIKit

//MARK - Main API Controller

/**
A public class for calling various methods on the Flickr API.
*/
public class FlickrAPIController: NSObject {
  
  /**
  The completion block for callers of public methods in this class.
  
  :param: success - true if the operation was successful, false if not.
  :param: result - The result dictionary from the API request, or null if the request failed.
  */
  public typealias FlickrAPICompletion = (success: Bool, result: NSDictionary?) -> ()
  
  
  /**
  The completion block for callers of private methods within this class. 
  
  :param: responseDict  The serialized JSON dictionary returned by the Flickr API, if one exists.
  :param: error         Any error associated with calling the API.
  */
  typealias InternalAPICompletion = (responseDict: NSDictionary?, error: NSError?) -> ()

  /**
  The main internal method for calling the Flickr API.
  
  :param: httpMethod  The HTTPMethod to use.
  :param: params      Non-standard parameters as a dictionary of keys and values. Will always at least include the Method.
  :param: completion  A closure to run upon completion, matching the signature of the completion block for an NSURLSessionDataTask.
  */
  func makeAPIRequest(httpMethod: HTTPMethod,
    params: [String: String],
    completion: InternalAPICompletion) {
      
      var queryItems = [NSURLQueryItem]()
      let allKeys = params.keys.array
      let allValues = params.values.array
      for i in 0 ..< allKeys.count {
        let queryItem = NSURLQueryItem(name: allKeys[i], value: allValues[i])
        queryItems.append(queryItem)
      }
      
      let components = FlickrAPIComponents()
      
      if let url = components.urlWithParams(queryItems) {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = httpMethod.rawValue
        NSURLSession.sharedSession()
          .dataTaskWithRequest(request, completionHandler: {
            (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let unwrappedError = error {
              //Error has occurred, fire completion.
              NSLog("Error with API request: \(unwrappedError)")
              completion(responseDict: nil, error: unwrappedError)
            } else {
              //Parse the data into a dictionary.
              var jsonError: NSError?
              let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
              completion(responseDict:dict, error: nil)
            }
          }).resume() //Don't forget to call Resume.
      } else {
        NSLog("URL FAIL!")
      }
  }
  
  /**
  Pings Flickr's Echo API endpoint, which helps ensure that you are properly creating and receiving results of requests.
  
  :param: completion The completion block to execute when the call returns.
  */
  public func pingEchoEndpointWithCompletion(completion:FlickrAPICompletion) {
    let paramsDict = [ FlickrParameterName.Method.rawValue : FlickrMethod.Echo.rawValue ]
    makeAPIRequest(HTTPMethod.GET, params: paramsDict) {
      (responseDict, error) -> Void in
      if let returnedError = error {
        self.fireCompletionOnMainQueueWithSuccess(false, result: nil, completion: completion)
      } else {
        self.fireCompletionOnMainQueueWithSuccess(true, result: responseDict, completion: completion)
      }
    }
  }
  
  /**
  Fires the passed-in completion block on the main thread with the given data.
  
  :param: success    The success value to pass to the completion block.
  :param: result     The result value to pass to the completion block.
  :param: completion The completion block to fire.
  */
  private func fireCompletionOnMainQueueWithSuccess(success: Bool, result: NSDictionary?, completion:FlickrAPICompletion) {
    if (NSThread.currentThread() == NSThread.mainThread()) {
      //We're already on the main thread
      completion(success: success, result: result)
    } else {
      //Get the main thread.
      NSOperationQueue.mainQueue().addOperationWithBlock {
        completion(success: success, result: result)
      }
    }
  }
  
  /**
  Requests and retrieves a JSON dictionary of photos with the given tag.
  
  :param: tag        The tag to search for on Flickr.
  :param: completion The completion block to execute when the call returns.
  */
  public func fetchPhotosForTag(tag: String, completion:FlickrAPICompletion) {
    let paramsDict = [
      FlickrParameterName.Method.rawValue : FlickrMethod.Search.rawValue,
      FlickrSearchParameterName.Tags.rawValue : tag
    ]
    
    makeAPIRequest(HTTPMethod.GET, params: paramsDict) {
      (responseDict, error) -> Void in
      if let returnedError = error {
        self.fireCompletionOnMainQueueWithSuccess(false, result: nil, completion: completion)
      } else {
        self.fireCompletionOnMainQueueWithSuccess(true, result: responseDict, completion: completion)
      }
    }
  }
  
  //TODO: Add user data fetch method.
}

//MARK - Mock API Controller

/**
A mock version of the API controller which loads data from disk and returns it instead of calling the API directly.
Note that normally, this would live in the Test bundle, but since we're on craptastic hotel WiFi at RWDevCon, it's living here in case we need to go to all mocking all the time.
*/
public class MockAPIController : FlickrAPIController {
  
  /**
  Loads up local JSON files and fires a completion block of the same format as real API calls.
  
  :param: fileName   The name, without the extension, of the JSON file to load.
  :param: completion The completion block to execute.
  */
  func JSONFromFileNamed(fileName: String, completion:FlickrAPICompletion) {
    //Pulling out the bundle like this allows you to use this kind of mocked API controller either here in the main package, or when you know you're going to have more reliable WiFi, only within the test package.
    let bundle = NSBundle(forClass: self.dynamicType)
    let path = bundle.pathForResource(fileName, ofType: "json")
    
    if let unwrappedPath = path {
      let dataFromPath = NSData(contentsOfFile: unwrappedPath)
      if let unwrappedData = dataFromPath {
        var error: NSError?
        let jsonDict = NSJSONSerialization.JSONObjectWithData(unwrappedData, options: NSJSONReadingOptions.MutableContainers, error: &error) as? NSDictionary
        if let unwrappedJSON = jsonDict {
          completion(success: true, result: unwrappedJSON)
          
          //You've fired the completion block - everything else is irrelevant.
          return
        } //Else JSON didn't unwrap
      } //Else NSData didn't unwrap
    } //Else path didn't unwrap
    
    //In any case: Fail.
    completion(success: false, result: nil)
  }
  
  //TODO: Add mock fetch for user data.
  
  public override func fetchPhotosForTag(tag: String, completion:FlickrAPICompletion) {
    JSONFromFileNamed("test_\(tag)" , completion: completion)
  }
  
  public override func pingEchoEndpointWithCompletion(completion: FlickrAPICompletion) {
    //TODO: Add mock ping of Echo endpoint. 
  }
}


