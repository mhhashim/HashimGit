//
//  HashimGitTests.swift
//  HashimGitTests
//
//  Created by Hashim M H on 20/02/21.
//

import XCTest
@testable import HashimGit

class HashimGitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let sut = TestClass()
        let result = sut.testFunc(a:1, b:2)
        XCTAssertEqual(result, 3)
    }

}
