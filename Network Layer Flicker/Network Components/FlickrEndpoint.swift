//
//  FlickrEndpoint.swift
//  Network Layer Flicker
//
//  Created by Vignesh on 29/03/22.
//

import Foundation

enum FlickrEndpoint : EndPoints{
    
    case getSearchResults(searchText: String, page: Int)
    
    
    var scheme: String {
        switch self{
        default :
            return "https"
        }
    }
    
    var baseURL: String{
        switch self{
        default :
            return "api.flickr.com"
        }
    }
    
    var path: String
    {
        switch self{
        case .getSearchResults:
            return "/services/rest/"
        }
    }
    
    var parameters: [URLQueryItem]{
        let apiKey = "675894853ae8ec6c242fa4c077bcf4a0"
        
        switch self{
        case .getSearchResults(let searchText, let page):
            return [URLQueryItem(name: "text", value: searchText),
                    URLQueryItem(name: "page", value: String(page)),
                     URLQueryItem(name: "method", value: "flickr.photos.search"),
                      URLQueryItem(name: "format", value: "json"),
                       URLQueryItem(name: "per_page", value: "20"),
                        URLQueryItem(name: "nojsoncallback", value: "1"),
                         URLQueryItem(name: "api_key", value: apiKey)]
        }
    }
    
    var method: String
    {
        switch self{
        case .getSearchResults:
            return "GET"
        }
    }
    
}
