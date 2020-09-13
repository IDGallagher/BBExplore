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

    /// Test the presenter filters characters correctly
    func testSearchAndFilter() throws {
        
        stub(condition: isAbsoluteURLString(Constants.apiCharacters)) { _ in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("charactersMock.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        let fetchListItems = expectation(description: "fetch character data")
        
        let apiService: CharacterAPI = BBAPIService()
        let interactor = CharacterInteractor(apiService: apiService)
        let presenter = CharacterListPresenter(router: nil, interactor: interactor)
        
        /// Refresh is asynchronous so wait for it to finish before testing
        presenter.refresh()
        
        var started: Bool = false
        presenter.listItems.observeNext(){ listItems in
            guard listItems != nil else { return }
            if !started {
                started = true
                testSearch()
                fetchListItems.fulfill()
            }
        }.dispose(in: bag)
    
        /// Run tests
        func testSearch() {
            presenter.set(searchFilter: "Tr")
            XCTAssertTrue(presenter.listItems.value?.count == 3)
            presenter.set(searchCategory: SearchCategoryEntity(uid: 1, title: ""))
            XCTAssertTrue(presenter.listItems.value?.count == 0)
            presenter.set(searchCategory: SearchCategoryEntity(uid: 2, title: ""))
            XCTAssertTrue(presenter.listItems.value?.count == 1)
            presenter.set(searchCategory: SearchCategoryEntity(uid: 3, title: ""))
            XCTAssertTrue(presenter.listItems.value?.count == 3)
            presenter.set(searchFilter: "t")
            XCTAssertTrue(presenter.listItems.value?.count == 23)
            XCTAssertTrue(presenter.listItems.value?.first?.title == "Walter White")
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}
