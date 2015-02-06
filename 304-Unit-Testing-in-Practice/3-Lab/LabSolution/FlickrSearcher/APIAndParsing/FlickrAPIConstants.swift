//
//  FlickrAPIConstants.swift
//  FlickrSearcher
//
//  Created by Ellen Shapiro on 11/30/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

import UIKit

/**
A file to store various String and Enum constants related to the Flickr API
*/

//Request your own API keys here after logging in to Flickr: https://www.flickr.com/services/apps/create/apply/?
public enum FlickrAuthCredential : String {
  case APIKey = "262cabe358a00f6f9977965c287249c3"
}

//Names of parameters to be used in URL construction
enum FlickrParameterName : String {
  case APIKey = "api_key"
  case Format = "format"
  case CleanJSON = "nojsoncallback"
  case Method = "method"
}

//Values of parameters to be used in URL construction
public enum FlickrParameterValue : String {
  case CleanJSON = "1"
  case Format = "json"
  case TestTag = "cats"
}

//API endpoints
enum FlickrMethod : String {
  case Search = "flickr.photos.search"
  case Echo = "flickr.test.echo"
  case Person = "flickr.people.getInfo"
}

//https://www.flickr.com/services/api/flickr.photos.search.html
enum FlickrSearchParameterName : String {
  case Tags = "tags"
  case Text = "text"
  case UserID = "user_id"
  case SafeSearch = "safe_search"
  case Sort = "sort"
}

//Ways to sort your photos
enum FlickrSortOrders : String {
  case PostedAscending = "date-posted-asc"
  case PostedDescending = "date-posted-desc"
  case TakenAscending = "date-taken-asc"
  case TakenDescending = "date-taken-desc"
  case InterestingnessDescending = "interestingness-desc"
  case InterestingnessAscending = "interestingness-asc"
  case Relevance = "relevance"
}

//The HTTP method to use for this
enum HTTPMethod : String {
  case GET = "GET"
  case POST = "POST"
}

//Generic JSON keys
public enum FlickrReturnDataJSONKeys : String {
  case Status = "stat"
  case InnerContent = "_content"
  case PhotoEnclosingDict = "photos"
  case ListOfPhotos = "photo"
}

//JSON keys associated with Photo data
enum FlickrPhotoDataJSONKeys : String {
  case ID = "id"
  case Farm = "farm"
  case Owner = "owner"
  case Server = "server"
  case Secret = "secret"
  case Title = "title"
}

//JSON keys associated with User data
enum FlickrUserDataJSONKeys : String {
  case ID = "id"
  case Person = "person"
  case Username = "username"
  case IconFarm = "iconfarm"
  case IconServer = "iconserver"
  case NSID = "nsid"
}

//The various sizes of photo which can be requested.
public enum FlickrPhotoSize : String {
  case Thumbnail = "q"
  case Small320 = "n"
  case Medium640 = "z"
  case Large1024 = "b"
  case Large1600 = "h"
}