//
//  ToTeacherMainScreenUITest.swift
//  Project190UITests
//
//  Created by Luis Campos on 11/17/23 4:31pm.
//

import XCTest

final class ToTeacherMainScreenUITest: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    // This test is supposed to verify the process of registering as a teacher and trying to get to the main teacher screen.
    func testPathToTeacherMain() throws {
        // UI tests must launch the application that they test.
        app.launch()
        
        getToLogin()
        openRegisterWindow()
        teacherRegister()
        teacherLogin()
        
        let mainButton = app.buttons["MAIN"]
        XCTAssertTrue(mainButton.exists)
        
        let requestsButton = app.buttons["Requests"]
        XCTAssertTrue(requestsButton.exists)
        
        let whiteListButton = app.buttons["Whitelist"]
        XCTAssertTrue(whiteListButton.exists)
        
        let manageUsersButton = app.buttons["Manage Users"]
        XCTAssertTrue(manageUsersButton.exists)
        
        let connectCodeButton = app.buttons["Connect Code"]
        XCTAssertTrue(connectCodeButton.exists)
        
        let settingsButton = app.buttons["Settings"]
        XCTAssertTrue(settingsButton.exists)
        
        let masterControlButton = app.buttons["Master Control"]
        XCTAssertTrue(masterControlButton.exists)
        
        let logoutButton = app.buttons["Logout"]
        XCTAssertTrue(logoutButton.exists)
    }
    func getToLogin(){
        XCTContext.runActivity(named: "Open App, Get to Login Page, and get Teacher login textfields to appear"){activity in
            let accept = app.buttons["Accept"]
            XCTAssertTrue(accept.exists)
            accept.tap()
            
            let teacher = app.buttons["Teacher"]
            XCTAssertTrue(teacher.exists)
            teacher.tap()
        }
    }
    func openRegisterWindow(){
        XCTContext.runActivity(named: "Open Register View"){activity in
            let signUp = app.buttons["Sign up here!"]
            XCTAssertTrue(signUp.exists)
            signUp.tap()
            
            let userTeacher = app.buttons["Teacher"]
            XCTAssertTrue(userTeacher.exists)
            
            let userStudent = app.buttons["Student"]
            XCTAssertTrue(userStudent.exists)
        }
    }
    func teacherRegister(){
        XCTContext.runActivity(named: "Register Teacher User"){activity in
            let teacherButton = app.buttons["Teacher"]
            XCTAssertTrue(teacherButton.exists)
            teacherButton.tap()
            
            let teacherFirst = app.textFields["First Name"]
            XCTAssertTrue(teacherFirst.exists)
            teacherFirst.tap()
            teacherFirst.typeText("Mickey")
            
            let teacherLast = app.textFields["Last Name"]
            XCTAssertTrue(teacherLast.exists)
            teacherLast.tap()
            teacherLast.typeText("Mouse")
            
            let teacherEmail = app.textFields["Email"]
            XCTAssertTrue(teacherEmail.exists)
            teacherEmail.tap()
            teacherEmail.typeText("mm.wdw28@gmail.com")
            
            let teacherPassword = app.secureTextFields["Password"]
            XCTAssertTrue(teacherPassword.exists)
            
            teacherPassword.doubleTap()
            teacherPassword.typeText("M3ck2yM45s2")
            
            
            let teacherConfirmPassword = app.secureTextFields["Confirm Password"]
            XCTAssertTrue(teacherConfirmPassword.exists)
            
            teacherConfirmPassword.doubleTap()
            teacherConfirmPassword.typeText("M3ck2yM45s2")
            
            let register = app.buttons["Register"]
            XCTAssertTrue(register.exists)
            register.tap()
        }
    }
    func teacherLogin(){
        XCTContext.runActivity(named: "Login as a Teacher"){activity in
            let teacherLogin = app.buttons["Teacher"]
            XCTAssertTrue(teacherLogin.exists)
            teacherLogin.tap()
            
            let teacherLoginEmail = app.textFields["Email"]
            XCTAssertTrue(teacherLoginEmail.exists)
            teacherLoginEmail.tap()
            teacherLoginEmail.typeText("mm.wdw28@gmail.com")
            
            let teacherLoginPassword = app.secureTextFields["Password"]
            XCTAssertTrue(teacherLoginPassword.exists)
            teacherLoginPassword.doubleTap()
            teacherLoginPassword.typeText("M3ck2yM45s2")
            
            let login=app.buttons["Login"]
            XCTAssertTrue(login.exists)
            login.tap()
        }
    }
}
