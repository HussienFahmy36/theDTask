//
//  JsonParserCodableTests.swift
//  DdotAssignmentTests
//
//  Created by Hussien Gamal Mohammed on 9/1/19.
//  Copyright © 2019 Ddot. All rights reserved.
//

import XCTest
@testable import DdotAssignment


class JsonParserCodableTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testLoadRepFirstPage() {
        let networkManager = NetworkManager()
        networkManager.reachability = Reachability()
        let urlString = "https://api.github.com/users/JakeWharton/repos?page=1&per_page=15"
        guard let sampleURL = URL.init(string: urlString) else {
            XCTFail("URL not valid")
            return
        }
        let expectation = self.expectation(description: "Loading sample file async")
        networkManager.getRequestAsync(from: sampleURL) { (data, error) in
            expectation.fulfill()
            let parser = JsonParserCodable()
            let result = parser.parse(data: data, to: [Repository].self)
            XCTAssertNotNil(result)
            XCTAssertTrue(result?.count ?? 0 > 0)
        }
        waitForExpectations(timeout: 2, handler: nil)

    }



}
