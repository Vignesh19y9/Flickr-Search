//
//  FlickrModels.swift
//  Network Layer Flicker
//
//  Created by Vignesh on 29/03/22.
//

import Foundation

struct FlickrResponse: Codable{
    let photos: FlickrResultsPage?
}

struct FlickrResultsPage: Codable{
    
    let page: Int
    let pages: Int
    let photo: [FlickPhoto]
}

struct FlickPhoto: Codable{
    
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
}

struct FlickImageUrl{
    let flickPhoto: FlickPhoto
    var url:String{
        return "http://farm\(flickPhoto.farm).static.flickr.com/\(flickPhoto.server)/\(flickPhoto.id)_\(flickPhoto.secret).jpg"
    }
}

//http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg
