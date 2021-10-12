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
        func testFetchCurrency() {
           implementationUnderTests.fetchCurrencyList(for: "ZAR")
           XCTAssertEqual(14, implementationUnderTests.currencyList.keys.count)
        }
    }
    
}
