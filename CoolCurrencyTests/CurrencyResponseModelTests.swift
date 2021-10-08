//
//  CurrencyResponseModelTests.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/10/08.
//

import XCTest
@testable import CoolCurrency

class CurrencyResponseModelTests: XCTestCase {

    var implementationUnderTests: CurrencyRepositable!
    
    override func setUpWithError() throws {
        implementationUnderTests = MockedCurrencyRepository()
    }
    
    func testCurrencyRequest() {
        let waitingForCompletionException = expectation(description: "Waiting for Currency API to respond using Currency code")
        implementationUnderTests.performCurrencyRequest(for: "ZAR") { _ in
            waitingForCompletionException.fulfill()
        }
        wait(for: [waitingForCompletionException], timeout: 5)
    }
}
