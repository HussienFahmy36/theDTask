//
//  NetworkManagerTests.swift
//  DdotAssignmentTests
//
//  Created by Hussien Gamal Mohammed on 9/1/19.
//  Copyright © 2019 Ddot. All rights reserved.
//

import XCTest
@testable import DdotAssignment
class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager?
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
    }

    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }
    func testsLoadDataFromURLAsync() {
        let urlString = "https://api.github.com/users/JakeWharton/repos?page=1&per_page=15"
        guard let sampleURL = URL.init(string: urlString) else {
            XCTFail("URL not valid")
            return
        }
        let expectation = self.expectation(description: "Loading sample file async")
        networkManager?.getRequestAsync(from: sampleURL) { (data, error) in
            expectation.fulfill()
            XCTAssertNotNil(data, "Loaded data is not nil")
        }
        waitForExpectations(timeout: 2, handler: nil)

    }
}
