//
//  LoginUITest.swift
//  CoolCurrencyUITests
//
//  Created by Vincent Moyo on 2021/12/13.
//

import XCTest

class LoginUITest: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        self.app = XCUIApplication()
        app.launch()
    }
    
    func testLoginButtons() {
        app.windows.children(matching: .other).element(boundBy: 0).buttons["Log In"].tap()
        
        app.textFields["Email"].tap()
        app.keys["a"].tap()
        app.keys["b"].tap()
        app.keys["c"].tap()
        app.keys["more"].tap()
        app.keys["@"].tap()
        app.keys["1"].tap()
        app.keys["2"].tap()
        app.keys["3"].tap()
        app.keys["."].tap()
        app.keys["more"].tap()
        app.keys["c"].tap()
        app.keys["o"].tap()
        app.keys["m"].tap()
        
        app.secureTextFields["Password"].tap()
        app.keys["more"].tap()
        app.keys["1"].tap()
        app.keys["2"].tap()
        app.keys["3"].tap()
        app.keys["4"].tap()
        app.keys["5"].tap()
        app.keys["6"].tap()
        app.staticTexts["Log In"].tap()
        
        XCTAssert(app.tabBars["Tab Bar"].buttons["Compare"].waitForExistence(timeout: 5) )
    }
}
