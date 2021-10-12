//
//  CurrencyResponseModelTest.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/10/11.
//

import XCTest
@testable import CoolCurrency

class CurrencyResponseModelTests: XCTestCase {
    
    var implementationUnderTests: MockedCurrencyRepository!
    
    override func setUp() {
        implementationUnderTests = MockedCurrencyRepository()
        
    }
    
    func testCurrencyRequestSuccess() {
        implementationUnderTests.shouldFail = false
        implementationUnderTests.performCurrencyRequest(for: "ZAR") { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(1.1, response.response.rates.greatBritishPound)
            case .failure(_):
                XCTFail("Should not fail")
            }
        }
    }
    
    func testCurrencyRequestFail() {
        implementationUnderTests.shouldFail = true
        implementationUnderTests.performCurrencyRequest(for: "SAR") { result in
            switch result {
            case .success(_):
                XCTFail("Should not Succeed")
            case .failure(let response):
                XCTAssertEqual("There was an error in retrieving data", response.localizedDescription)
            }
        }
    }
}
