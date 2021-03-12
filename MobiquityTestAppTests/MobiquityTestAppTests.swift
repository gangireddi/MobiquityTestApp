//
//  MobiquityTestAppTests.swift
//  MobiquityTestAppTests
//
//  Created by Sandy Gangireddi on 10/03/21.
//  Copyright © 2021 Sandy. All rights reserved.
//

import XCTest
@testable import MobiquityTestApp

class MobiquityTestAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//I wrote unit-test cases for API related stuff for now
    func testForValidAPIKey() {
      XCTAssertEqual(API_KEY, "fae7190d7e6433ec3a45285ffcf55c86", "Valid Api key is using")
    }
    
    func testForValidImperialUnit() {
      XCTAssertEqual(IMPERIAL, "imperial", "Valid unit type used")
    }
    
    func testForValidMetricUnit() {
      XCTAssertEqual(METRIC, "metric", "Valid unit type used")
    }

}
