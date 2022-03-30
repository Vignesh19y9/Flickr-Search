//
//  Network_Layer_FlickerTests.swift
//  Network Layer FlickerTests
//
//  Created by Vignesh on 29/03/22.
//

import XCTest
@testable import Network_Layer_Flicker

class Network_Layer_FlickerTests: XCTestCase {
    
    let viewModel = ViewModel(apiManager: dummyClassApi())

    func testViewModelParseUrl(){
        let response = FlickrResponse(photos: FlickrResultsPage(page: 1, pages: 1, photo: [FlickPhoto(id: "001", owner: "0", secret: "002", server: "003", farm: 1)]))
        
        let result = viewModel.parseUrl(response: response)[0].url
        XCTAssertEqual(result,"http://farm1.static.flickr.com/003/001_002.jpg")
    }

}

class dummyClassApi : NetworkProtocol{
    
}
