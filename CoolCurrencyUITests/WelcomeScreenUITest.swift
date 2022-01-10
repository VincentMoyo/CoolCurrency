//
//  WelcomeScreenUITest.swift
//  CoolCurrencyUITests
//
//  Created by Vincent Moyo on 2021/12/13.
//

import XCTest

class WelcomeScreenUITest: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        self.app = XCUIApplication()
        app.launch()
    }
    
    func testLoginButton() {
        app.windows.children(matching: .other).element(boundBy: 0).buttons["Log In"].tap()
    }
    
    func testRegisterButton() {
        app.windows.children(matching: .other).element(boundBy: 0).buttons["Register"].tap()
    }
}
