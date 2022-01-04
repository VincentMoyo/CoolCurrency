//
//  MatchingGameUITest.swift
//  CoolCurrencyUITests
//
//  Created by Vincent Moyo on 2021/12/15.
//

import XCTest

class MatchingGameUITest: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        self.app = XCUIApplication()
        app.launch()
    }
    
    func testPlayGamePicker() {
        let pickersQuery = app.pickers
        let pickerWheel1 = pickersQuery.children(matching: .pickerWheel).element(boundBy: 0)
        let pickerWheel2 = pickersQuery.children(matching: .pickerWheel).element(boundBy: 1)
        
        pickerWheel1.swipeDown()
        pickerWheel2.swipeDown()
        pickerWheel1.swipeDown()
        
        app.buttons.containing(.staticText, identifier: "Match").element.tap()
        app.alerts["Incorrect"].scrollViews.otherElements.buttons["OK"].tap()
    }
    
    func testPlayAgainButtonSuccess() {
        for _ in 0..<5 {
            app.staticTexts["Match"].tap()
            app.alerts["Incorrect"].scrollViews.otherElements.buttons["OK"].tap()
        }
        XCTAssert(app.staticTexts["Play Again"].exists)
        app.staticTexts["Play Again"].tap()
    }
    
    func testPlayAgainButtonFailure() {
        app.staticTexts["Match"].tap()
        app.alerts["Incorrect"].scrollViews.otherElements.buttons["OK"].tap()
        XCTAssertFalse(app.staticTexts["Play Again"].exists)
    }
}
