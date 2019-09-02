//
//  RepositoriesDataLoaderTests.swift
//  DdotAssignmentTests
//
//  Created by Hussien Gamal Mohammed on 9/1/19.
//  Copyright © 2019 Ddot. All rights reserved.
//

import XCTest
@testable import DdotAssignment
class RepositoriesDataLoaderTests: XCTestCase {

    var repositoriesDataLoader: RepositoriesDataLoader?
    override func setUp() {
        repositoriesDataLoader = RepositoriesDataLoader()
    }

    override func tearDown() {
        repositoriesDataLoader = nil
    }

    func testLoadRepositories() {
        let expectation = self.expectation(description: "Loading repos")
        repositoriesDataLoader?.remoteLoadRepositories(completionBlock: { (result, error) in
            expectation.fulfill()
            XCTAssertNotNil(result)
        })
        waitForExpectations(timeout: 2, handler: nil)

    }

    func testLoadRepositoriesLocal() {
        let expectation = self.expectation(description: "Loading repos")
        repositoriesDataLoader?.localLoadRepositories(completionBlock: { (result, error) in
            expectation.fulfill()
            XCTAssertNotNil(result)
        })
        waitForExpectations(timeout: 2, handler: nil)

    }

    func testLoadRepositoriesFiveRecords() {
        repositoriesDataLoader?.recordsPerPage = 5
        let expectation = self.expectation(description: "Loading repos with 5 per page")
        repositoriesDataLoader?.remoteLoadRepositories(completionBlock: { (result, error) in
            expectation.fulfill()
            XCTAssertNotNil(result)
            XCTAssertNotNil(result?.count == 5)

        })
        waitForExpectations(timeout: 2, handler: nil)

    }

    func testloadRepositories() {
        let expectation = self.expectation(description: "Loading repos with 5 per page")
        repositoriesDataLoader?.loadRepositories(completionBlock: { (result, error) in
            expectation.fulfill()
            XCTAssertNotNil(result)

        })
        waitForExpectations(timeout: 2, handler: nil)

    }

    func testLoadRepositoriesInvalidPageId() {
        repositoriesDataLoader?.pageID = 15000303030303030
        let expectation = self.expectation(description: "Loading repos with 5 per page")
        repositoriesDataLoader?.remoteLoadRepositories(completionBlock: { (result, error) in
            expectation.fulfill()
            XCTAssertTrue(result?.count == 0)


        })
        waitForExpectations(timeout: 2, handler: nil)

    }

}
