//
//  ConversionCurrencyViewModelTests.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/10/26.
//
//
 import XCTest
 @testable import CoolCurrency

 class ConversionCurrencyViewModelTests: XCTestCase {

    private var implementationUnderTests: ConversionCurrencyViewModel!

    private var mockData: ConvertCurrencyDataModel {
        ConvertCurrencyDataModel(primaryCurrentName: "Rand",
                                 primaryCurrencyFlagName: "SouthAfricanFlag",
                                 secondCurrency: 4.0,
                                 secondCurrentName: "Yen",
                                 secondaryCurrencyFlagName: "JapaneseFlag")
    }

    override func setUp() {
       implementationUnderTests = ConversionCurrencyViewModel()
    }

    func testMultiplierByFourSuccess() {
        implementationUnderTests.set(mockData)
        let finalAnswer = implementationUnderTests.multiplyCurrency(by: 4.0)
        XCTAssertEqual("16.000000", finalAnswer)
    }

    func testSetSecondaryCurrencySuccess() {
        implementationUnderTests.set(mockData)
        implementationUnderTests.setSecondaryCurrency(5.0)
        XCTAssertEqual("5.000000", implementationUnderTests.secondaryCurrency())

    }
 }
