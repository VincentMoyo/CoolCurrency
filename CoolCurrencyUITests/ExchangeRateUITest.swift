//
//  ExchangeRateUITest.swift
//  CoolCurrencyUITests
//
//  Created by Vincent Moyo on 2021/12/14.
//

import XCTest

class ExchangeRateUITest: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        self.app = XCUIApplication()
        app.launch()
    }
    
    func testLoginButtons() {
        app.pickerWheels["Real"].swipeDown()
    }
    
    func testRefreshExchangeRate() {
        app.pickerWheels["Pound"].swipeDown()
        app.staticTexts["Refresh"].tap()
    }
    
    func testConvertCurrencyToBaseCurrency() {
        app.pickerWheels["Pound"].swipeDown()
        XCTAssert(app.tables.staticTexts["Dollar"].exists)
    }
}
