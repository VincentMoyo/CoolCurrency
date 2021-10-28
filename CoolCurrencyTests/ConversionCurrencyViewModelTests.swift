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
       implementationUnderTests = ConvertCurrencyViewModel()
    }

    func testMultiplierByFourSuccess() {
        implementationUnderTests.set(mockData)
        let finalAnswer = implementationUnderTests.multiplyCurrencyBy(4.0)
        XCTAssertEqual("20", finalAnswer)
    }

    func testSetSecondaryCurrencySuccess() {
        implementationUnderTests.set(mockData)
        let finalAnswer = implementationUnderTests.setSecondaryCurrency(5.0)
        XCTAssertEqual("5.0", finalAnswer)

    }
 }
