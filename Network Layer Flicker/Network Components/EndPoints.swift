//
//  EndPoints.swift
//  Network Layer Flicker
//
//  Created by Vignesh on 29/03/22.
//

import Foundation

protocol EndPoints{
    
    // HTTP or HTTPS
    var scheme : String {get}
    // Example : api.flickr.com
    var baseURL : String {get}
    // after the base url : /services/rest/
    var path : String {get}
    // name and Api key
    var parameters : [URLQueryItem] {get}
    // GET / POST
    var method : String {get}
}
