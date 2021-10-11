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
    
    override func setUpWithError() throws {
        implementationUnderTests = MockedCurrencyViewModel(repository: MockedCurrencyRepository())
    }

    func testFetchCurrency() {
        let waitingForCompletionException = expectation(description: "Waiting for Currency API to respond using Currency code")
        implementationUnderTests.fetchCurrencyList(for: "ZAR")
        if implementationUnderTests.currencyList != [:] {
            waitingForCompletionException.fulfill()
        }
        wait(for: [waitingForCompletionException], timeout: 5)
    }

}
