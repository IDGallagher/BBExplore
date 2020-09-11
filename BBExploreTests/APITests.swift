//
//  APITests.swift
//  BBExploreTests
//
//  Created by Ian Gallagher on 10/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import Foundation
import XCTest
import OHHTTPStubs
@testable import BBExplore

class APITests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        HTTPStubs.removeAllStubs()
    }

    /// Test the api service parses CharacterEntities correctly
    func testCharacterAPI() throws {
        
        stub(condition: isAbsoluteURLString(Constants.apiCharacters)) { _ in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("charactersMock.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        let fetchCharacters = expectation(description: "fetch character data")
        
        let apiService: CharacterAPI = APIService()
        
        apiService.fetchCharacters() { statusCode, characters in
            XCTAssertTrue(characters != nil && characters!.count > 1)
            fetchCharacters.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    /// Test the api service reacts to backend errors
    func testCharacterAPIFail() throws {
        
        stub(condition: isAbsoluteURLString(Constants.apiCharacters)) { _ in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("backendErrorMock.json", type(of: self))!,
                statusCode: 500,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        let fetchCharacters = expectation(description: "fetch character data")
        
        let apiService: CharacterAPI = APIService()
        
        apiService.fetchCharacters() { statusCode, characters in
            XCTAssertTrue(statusCode == 500)
            fetchCharacters.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
