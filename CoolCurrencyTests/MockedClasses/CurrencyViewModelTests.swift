//
//  CurrencyViewModelTests.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/10/08.
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
        implementationUnderTests.modelLoad = { result in
            if result {
                waitingForCompletionException.fulfill()
            }
        }
        implementationUnderTests.fetchCurrencyList(for: "ZAR")
        wait(for: [waitingForCompletionException], timeout: 5)
    }

}
