//
//  ViewModel.swift
//  Network Layer Flicker
//
//  Created by Vignesh on 29/03/22.
//

import Foundation

class ViewModel: NSObject{
    
    var searchtext: String?
    var pageNo : Int = 1
    var apiManager : NetworkProtocol
    //MVVM Binding is done using property observer & closure
    //in large project use boxing technique
    var bindCallBack : (() -> ()) = {}
    var photoUrl: [FlickImageUrl]{
        didSet{
            self.bindCallBack()
        }
    }
    //intializer with properties used for dependency injection
    init(apiManager : NetworkProtocol){
        self.apiManager = apiManager
        self.photoUrl = []
    }
    
    func search(key : String?){
        if(key != nil){
            
            print("Searching... ", key!)
            self.searchtext = key
            fetchImageApi()
        }
    }
    
    func fetchImageApi(){
        
        NetworkEngine().request(endpoint: FlickrEndpoint.getSearchResults(searchText: self.searchtext!, page: self.pageNo)){(result: Result<FlickrResponse, Error>)in
            
            switch result {
                
            case .success(let success):
                self.photoUrl = self.parseUrl(response: success)
                
            case .failure(let failure):
                print("Error in response : ",failure.localizedDescription)
            }
        }
    }
    //Not buisness logic should be moved to an utility class
    //unit testing module
    func parseUrl(response : FlickrResponse) ->[FlickImageUrl]{
        
        var urlList = [FlickImageUrl]()
        for images in response.photos!.photo{
            urlList.append(FlickImageUrl(flickPhoto:images))
        }
        if(urlList.count > 0){
            return urlList
        }
        return []
    }
}
