//
//  RegisterUITest.swift
//  CoolCurrencyUITests
//
//  Created by Vincent Moyo on 2021/12/14.
//

import XCTest

class RegisterUITest: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        self.app = XCUIApplication()
        app.launch()
    }
    
    func testRegisterButtons() {
        app.windows.children(matching: .other).element(boundBy: 0).buttons["Register"].tap()
        
        app.textFields["Email"].tap()
        app.keys["a"].tap()
        app.keys["more"].tap()
        app.keys["@"].tap()
        app.keys["1"].tap()
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
    
    func testRegisterButtonsEmailFormatError() {
        app.windows.children(matching: .other).element(boundBy: 0).buttons["Register"].tap()
        
        app.textFields["Email"].tap()
        app.keys["a"].tap()
        app.keys["more"].tap()
        app.keys["@"].tap()
        app.keys["1"].tap()
        
        app.secureTextFields["Password"].tap()
        app.keys["more"].tap()
        app.keys["1"].tap()
        app.keys["2"].tap()
        app.keys["3"].tap()
        app.keys["4"].tap()
        app.keys["5"].tap()
        app.keys["6"].tap()
        app.staticTexts["Log In"].tap()
        
        XCTAssertFalse(app.tabBars["Tab Bar"].buttons["Compare"].exists)
    }
    
    func testRegisterButtonsPasswordError() {
        app.windows.children(matching: .other).element(boundBy: 0).buttons["Register"].tap()
        
        app.textFields["Email"].tap()
        app.keys["a"].tap()
        app.keys["more"].tap()
        app.keys["@"].tap()
        app.keys["1"].tap()
        app.keys["."].tap()
        app.keys["more"].tap()
        app.keys["c"].tap()
        app.keys["o"].tap()
        app.keys["m"].tap()
        
        app.secureTextFields["Password"].tap()
        app.keys["more"].tap()
        app.keys["1"].tap()
        app.keys["2"].tap()
        app.staticTexts["Log In"].tap()
        
        XCTAssertFalse(app.tabBars["Tab Bar"].buttons["Compare"].exists)
    }
}
