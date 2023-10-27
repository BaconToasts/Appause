//
//  ForgotPasswordBlankTextFieldUITest.swift
//  Project190UITests
//
//  Created by user1 on 10/26/23.
//

import XCTest

final class ForgotPasswordBlankTextFieldUITest: XCTestCase {

    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    func testExample() throws {
        goToForgotPassword()
        let sendCodeButton = app.buttons["Send Code"]
        XCTAssertTrue(sendCodeButton.exists)
        
        sendCodeButton.tap()
        
        let popOKButton = app.popUpButtons["Ok"]
        XCTAssertTrue(popOKButton.exists)
        
        popOKButton.tap()
        
        XCTAssertTrue(sendCodeButton.exists)
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
    func goToForgotPassword(){
        setTeacherUp()
        let passwordButton = app.buttons["Forgot password?"]
        XCTAssertTrue(passwordButton.exists)
        
        passwordButton.tap()
    }
}

