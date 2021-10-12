//
//  CurrencyViewModelTest.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/10/11.
//

import XCTest
@testable import CoolCurrency

class CurrencyViewModelTests: XCTestCase {
    
    var implementationUnderTests: CurrencyViewModiable!
    
    override func setUp() {
        implementationUnderTests = MockedCurrencyViewModel(repository: MockedCurrencyRepository())
    }
    
    func testFetchCurrency() {
        let waitingForCompletionException = expectation(description: "Waiting for Currency API to respond using Currency code")
        implementationUnderTests.fetchCurrencyList(for: "ZAR")
        if implementationUnderTests.currencyList != [:] {
            waitingForCompletionException.fulfill()
            XCTAssertEqual(14, implementationUnderTests.currencyList.keys.count)
        }
        wait(for: [waitingForCompletionException], timeout: 5)
    }
    
}
