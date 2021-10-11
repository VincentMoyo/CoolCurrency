//
//  CurrencyResponseModelTest.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/10/11.
//

import XCTest
@testable import CoolCurrency

class CurrencyResponseModelTests: XCTestCase {
    
    var implementationUnderTests: CurrencyRepositable!
    
    override func setUp() {
        implementationUnderTests = MockedCurrencyRepository()
    }
    
    func testCurrencyRequest() {
        let waitingForCompletionException = expectation(description: "Waiting for Currency API to respond using Currency code")
        implementationUnderTests.performCurrencyRequest(for: "ZAR") { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(1.1, response.response.rates.greatBritishPound)
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
            waitingForCompletionException.fulfill()
        }
        wait(for: [waitingForCompletionException], timeout: 5)
    }

}
