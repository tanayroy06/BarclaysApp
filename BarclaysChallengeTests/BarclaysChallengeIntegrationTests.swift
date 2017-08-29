//
//  BarclaysChallengeTests.swift
//  BarclaysChallengeTests
//
//  Created by Tanay Kumar on 8/28/17.
//  Copyright © 2017 Tanay Kumar. All rights reserved.
//

import XCTest
@testable import BarclaysChallenge

class BarclaysChallengeIntegrationTests: XCTestCase {
    var apiManagerUnderTest: APIManager!
    
    override func setUp() {
        super.setUp()
        apiManagerUnderTest = APIManager()
        
    }
    
    override func tearDown() {
        apiManagerUnderTest = nil
        super.tearDown()
    }
    
    
    func testCallToiTunesCompletes() {

        let searchTerm = "jack+johnson"
        let entity = "musicVideo"

        let promise = expectation(description: "Error should be empty string")
        apiManagerUnderTest.getSearchResults(searchTerm: searchTerm, searchEntity: entity) { (result, error) in
            
            if error.isEmpty {
             promise.fulfill()
            }
            XCTAssertEqual(error, "")
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCallToiTunesFail() {
        
        let searchTerm = "jack"
        let entity = "all"
        
        let promise = expectation(description: "Error should have an invalid status code")
        apiManagerUnderTest.getSearchResults(searchTerm: searchTerm, searchEntity: entity) { (result, error) in
            
            if !error.isEmpty {
                promise.fulfill()
            }
            XCTAssertEqual(error, "Status code is not 200 Ok")
        }
        waitForExpectations(timeout: 5, handler: nil)
    
    }
    
    func testUpdateSearchResult(){
        
        let url = URL.init(string: "https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo")
        do {
            let data = try Data.init(contentsOf: url!)
            apiManagerUnderTest.updateSearchResults(data)
            
        } catch _{print("Error")}
        
        XCTAssertEqual(apiManagerUnderTest.searchResults.count, 32)
    }
    
    func testAllKeys() {
        
        let testDict = ["all" : "All", "movie" : "Movie", "podcast" : "Podcast", "music" : "Music", "musicVideo" : "Music Video", "audiobook" : "Audiobook", "shortFilm" : "Short Film", "tvShow" : "Tv Show", "software" : "Software", "ebook" : "ebook"]
        
        let keys = testDict.allKeys(forValue: "All")
        XCTAssertEqual(keys[0], "all")
    }
    
}
