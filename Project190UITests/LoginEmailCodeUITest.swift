//
//  LoginEmailCodeUITest.swift
//  Project190
//
//  Created by Luis Campos on 10/25/23.
//

import XCTest

final class LoginEmailCodeUITest: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        goToEmailCode()
    }
    func setTeacherUp(){
        getToLoginView()
        let teacherButton = app.buttons["Teacher Login"]
        XCTAssertTrue(teacherButton.exists)
        
        teacherButton.tap()
        
        let forgotPassword = app.buttons["Forgot password?"]
        XCTAssertTrue(forgotPassword.exists)
    }
    func getToLoginView(){
        app.launch()
        let eulaTitle = app.staticTexts["EULA"]
        let acceptButton = app.buttons["Accept"]
        XCTAssertTrue(eulaTitle.exists)
        XCTAssertTrue(acceptButton.exists)
        acceptButton.tap()
    }
    func goToEmailCode(){
        setTeacherUp()
        let passwordButton = app.buttons["Forgot password?"]
        XCTAssertTrue(passwordButton.exists)
        
        passwordButton.tap()
        
        let generateButton = app.buttons["Generate and Send Code"]
        XCTAssertTrue(generateButton.exists)
    }
}
