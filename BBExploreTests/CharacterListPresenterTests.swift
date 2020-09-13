//
//  CharacterListPresenterTests.swift
//  BBExploreTests
//
//  Created by Ian Gallagher on 10/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import Foundation
import XCTest
import OHHTTPStubs
@testable import BBExplore

class CharacterListPresenterTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        HTTPStubs.removeAllStubs()
    }

    /// Test the api service parses CharacterEntities correctly
    func testSearchAndFilter() throws {
        
        stub(condition: isAbsoluteURLString(Constants.apiCharacters)) { _ in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("charactersMock.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        let fetchListItems = expectation(description: "fetch character data")
        
        let apiService: CharacterAPI = APIService()
        let interactor = CharacterInteractor(apiService: apiService)
        let presenter = CharacterListPresenter(interactor: interactor)
        
        var count = -1
        presenter.listItems.observeNext(){ listItems in
//            print("\(listItems?[0])")
            guard listItems != nil else { return }
            count += 1
            print(count)
            if count == 0 {
                XCTAssertTrue(listItems!.count == 3)
                XCTAssertTrue(listItems![2].title == "Christian Ortgea")
                presenter.set(searchCategory: SearchCategoryEntity(uid: 2, title: ""))
            } else if count == 1 {
                presenter.set(searchFilter: "R")
//                print(listItems)
            } else {
//                print(listItems)
                fetchListItems.fulfill()
            }
            
        }.dispose(in: bag)
        
        presenter.set(searchFilter: "Rt")
        presenter.set(searchCategory: SearchCategoryEntity(uid: 1, title: ""))
        presenter.refresh()
        
        
        
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
