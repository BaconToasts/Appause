//
//  LoginView.swift
//  Project190
//
//  Created by Vlad Puriy on 4/10/23.
//
import SwiftUI
import MessageUI
import KeychainSwift
import Combine
import CoreHaptics

struct LoginView: View {
    //Stores the username and password even when app is closed
    public var keychain = KeychainSwift()
    
    @State private var showErrorMessages = false
    @State private var errorMessages = ""
    @State private var shakeOffset: CGFloat = 0.0
    
    @Binding var showNextView: DisplayState
    
    // Variables for button names
    @State var buttonNameTop = "Teacher Login"
    @State var buttonColorTopIdle = Color.black
    @State var buttonColorTopActive = Color.blue
    @State var buttonColorLogin = Color.blue
    
    
    @State var buttonNameBottom = "Student Login"
    @State var buttonColorBottomIdle = Color.black
    @State var buttonColorBottomActive = Color.blue
    
    
    
    @State var buttonColorTopSucess = Color.green
    @State var textFieldOpacity = Color.gray.opacity(0.2)
    
    @State var buttonColorTop = Color.black
    @State var buttonColorBottom = Color.black
    @State var showTextFields = false
    @State var showCodeField = false
    @State var usernameText = ""
    @State var passwordText = ""
    @State var studentPasswordText = ""
    @State var studentUsernameText = ""
    @State var codeText = ""
    @State var setUsername = ""
    @State var setPassword = ""
    @State var isLoginSuccessful = false
    @State var isRegistrationSuccessful = false
    @State var isStudentRegistrationSuccessful = false
    @State var isStudentLoginSuccessful = false
    
    var body: some View {
            VStack {
                
                //***************************** TEACHER LOGIN BUTTON ***********************************
                Button(action: {
                    self.showCodeField = false
                    self.showTextFields.toggle()
                    self.buttonColorTop = self.showTextFields ? buttonColorTopActive: buttonColorTopIdle
                    self.buttonColorBottom = self.showCodeField ? buttonColorTopActive : buttonColorTopIdle
                }) {
                    Text(buttonNameTop)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 20, alignment: .center)
                }
                .padding()
                .background(buttonColorTop)
                .cornerRadius(10)
                
                //********************************** STUDENT LOGIN BUTTON ******************************
                Button(action: {
                    self.showTextFields = false
                    self.showCodeField.toggle()
                    self.buttonColorTop = self.showTextFields ? buttonColorBottomActive: buttonColorBottomIdle
                    self.buttonColorBottom = self.showCodeField ? buttonColorBottomActive : buttonColorBottomIdle
                }) {
                    Text(buttonNameBottom)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 20, alignment: .center)
                }
                .padding()
                .background(buttonColorBottom)
                .cornerRadius(10)
                
                if showTextFields || showCodeField {
                    VStack {
                        HStack {
                            Text(showTextFields ? "Teacher Username:" : "Student Username:")
                            TextField("Enter Username", text: showTextFields ? $usernameText : $studentUsernameText)
                                .padding()
                                .background(textFieldOpacity)
                                .cornerRadius(10)
                                .frame(width: 180)
                        }
                        HStack {
                            Text(showTextFields ? "Teacher Password:" : "Student Password:")
                            SecureField("Enter Password", text: showTextFields ? $passwordText : $studentPasswordText)
                                .padding()
                                .background(textFieldOpacity)
                                .cornerRadius(10)
                                .frame(width: 180)
                        }
                        HStack {
                            //*********************** REGISTER BUTTON ************************//
                            Button(action: {
                                withAnimation {
                                    //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                                    showNextView = showTextFields ? .teacherRegister : .studentRegister
                                }
                                
                                //previous code used in place of registration
                                /*
                                let username = showTextFields ? usernameText : studentUsernameText
                                let password = showTextFields ? passwordText : studentPasswordText
                                let keychainUsernameKey = showTextFields ? "registeredTeacherUsername" : "registeredStudentUsername"
                                let keychainPasswordKey = showTextFields ? "registeredTeacherPassword" : "registeredStudentPassword"
                                
                                if username != "" && password != "" {
                                    keychain.set(username, forKey: keychainUsernameKey)
                                    keychain.set(password, forKey: keychainPasswordKey)
                                    showTextFields ? (isRegistrationSuccessful = true) : (isStudentRegistrationSuccessful = true)
                                } else {
                                    showTextFields ? (isRegistrationSuccessful = false) : (isStudentRegistrationSuccessful = false)
                                }*/
                            }) {
                                Text("Register")
                                    .foregroundColor(.white)
                                    .frame(width: 125, height: 20, alignment: .center)
                            }
                            .padding()
                            .background(buttonColorBottom)
                            .cornerRadius(10)
                            
                            if showErrorMessages && errorMessages == "registration" {
                                Text("Incorrect Username and Password. Try again.")
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                            //~~~~~~~~~~~~~~~~~~ end of register button ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                            //****************** LOGIN BUTTON *******************************//
                            Button(action: {
                                let registeredUsername = showTextFields ? keychain.get("teacherUserKey") : keychain.get("studentUserKey")
                                let registeredPassword = showTextFields ? keychain.get("teacherPassKey") : keychain.get("studentPassKey")
                                
                                //retrieves the username and password from the keychain depending on which type login is being used
                                let username = showTextFields ? usernameText : studentUsernameText
                                let password = showTextFields ? passwordText : studentPasswordText
                                
                                let isSuccessful = username == registeredUsername && password == registeredPassword
                                
                                if isSuccessful {
                                    showNextView = showTextFields ? .mainTeacher : .mainStudent
                                } else {
                                    withAnimation(.easeInOut(duration: 0.05).repeatCount(4, autoreverses: true)) {
                                        shakeOffset = 6
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                            shakeOffset = 0
                                        }
                                    }
                                    performShakeAnimation()
                                }
                                self.buttonColorTop = isSuccessful ? buttonColorTopSucess : buttonColorLogin
                            }) {
                                Text("Login")
                                    .foregroundColor(.white)
                                    .frame(width: 125, height: 20, alignment: .center)
                            }
                            .padding()
                            .background(buttonColorTop)
                            .cornerRadius(10)
                            .offset(x: shakeOffset)
                        
                            //~~~~~~~~~~~~~~~~~ END OF LOGIN BUTTON ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                            
                            .padding()
                        }
                    }
                }
            }
        }
    

                                
    
    
    /*
    var body: some View {
        VStack {
            
            //***************************** TEACHER LOGIN BUTTON ***********************************
            Button(action: {
                self.showCodeField = false
                self.showTextFields.toggle()
                self.buttonColorTop = self.showTextFields ? buttonColorTopActive: buttonColorTopIdle
                self.buttonColorBottom = self.showCodeField ? buttonColorTopActive : buttonColorTopIdle
            }) {
                Text(buttonNameTop)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            .padding()
            .background(buttonColorTop)
            .cornerRadius(10)
            
            //********************************** STUDENT LOGIN BUTTON ******************************
            Button(action: {
                self.showTextFields = false
                self.showCodeField.toggle()
                self.buttonColorTop = self.showTextFields ? buttonColorBottomActive: buttonColorBottomIdle
                self.buttonColorBottom = self.showCodeField ? buttonColorBottomActive : buttonColorBottomIdle
            }) {
                Text(buttonNameBottom)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            .padding()
            .background(buttonColorBottom)
            .cornerRadius(10)
            
            if showTextFields {
                VStack {
                    HStack {
                        Text("Username:")
                        TextField("Enter Username", text: $usernameText)
                            .padding()
                            .background(textFieldOpacity)
                            .cornerRadius(10)
                            .frame(width: 180)
                    }
                    HStack {
                        Text("Password:")
                        SecureField("Enter Password", text: $passwordText)
                            .padding()
                            .background(textFieldOpacity)
                            .cornerRadius(10)
                            .frame(width: 180)
                    }
                    HStack {
                        //*********************** REGISTER BUTTON FOR TEACHER ************************//
                        Button(action: {
                            if self.usernameText != "" && self.passwordText != "" {
                                keychain.set(self.usernameText, forKey: "registeredUsername")
                                keychain.set(self.passwordText, forKey: "registeredPassword")
                                self.isRegistrationSuccessful = true
                            } else {
                                self.isRegistrationSuccessful = false
                            }
                        }) {
                            Text("Register")
                                .foregroundColor(.white)
                                .frame(width: 125, height: 20, alignment: .center)
                        }
                        .padding()
                        .background(buttonColorBottom)
                        .cornerRadius(10)
                        
                        if showErrorMessages && errorMessages == "registration" {
                            Text("Incorrect Username and Password. Try again.")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        //~~~~~~~~~~~~~~~~~~ end of register button ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                        //****************** LOGIN BUTTON FOR TEACHER *******************************//
                        Button(action: {
                            let registeredUsername = keychain.get("registeredUsername")
                            let registeredPassword = keychain.get("registeredPassword")
                            
                            self.isLoginSuccessful = self.usernameText == registeredUsername && self.passwordText == registeredPassword
                            
                            if self.isLoginSuccessful {
                                self.showNextView = .mainTeacher
                            }else {
                                withAnimation(.easeInOut(duration: 0.05).repeatCount(4, autoreverses: true)) {
                                    shakeOffset = 6
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                        shakeOffset = 0
                                    }
                                }
                                performShakeAnimation()
                            }
                            self.buttonColorTop = self.isLoginSuccessful ? buttonColorTopSucess : buttonColorLogin
                        }) {
                            Text("Login")
                                .foregroundColor(.white)
                                .frame(width: 125, height: 20, alignment: .center)
                        }
                        .padding()
                        .background(buttonColorTop)
                        .cornerRadius(10)
                        .offset(x: shakeOffset)
                    
                        //~~~~~~~~~~~~~~~~~ END OF LOGIN BUTTON TEACHER ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                        
                        .padding()
                    }
                    // ********************** STUDENT LOGIN SECTION **********************************//
                    if showCodeField {
                        VStack {
                            HStack {
                                Text("Student Username:")
                                TextField("Enter Username", text: $studentUsernameText)
                                    .padding()
                                    .background(textFieldOpacity)
                                    .cornerRadius(10)
                                    .frame(width: 180)
                            }
                            HStack {
                                Text("Student Password:")
                                SecureField("Enter Password", text: $studentPasswordText)
                                    .padding()
                                    .background(textFieldOpacity)
                                    .cornerRadius(10)
                                    .frame(width: 180)
                            }
                            HStack {
                                // Student Register Button
                                Button(action: {
                                    if self.studentUsernameText != "" && self.studentPasswordText != "" {
                                        keychain.set(self.studentUsernameText, forKey: "registeredStudentUsername")
                                        keychain.set(self.studentPasswordText, forKey: "registeredStudentPassword")
                                        self.isStudentRegistrationSuccessful = true
                                    } else {
                                        self.isStudentRegistrationSuccessful = false
                                    }
                                }) {
                                    Text("Student Register")
                                        .foregroundColor(.white)
                                        .frame(width: 125, height: 20, alignment: .center)
                                }
                                .padding()
                                .background(buttonColorBottom)
                                .cornerRadius(10)
                                
                                if showErrorMessages && errorMessages == "student_registration" {
                                    Text("Incorrect Username and Password. Try again.")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                }
                                
                                // Student Login Button
                                
                                Button(action: {
                                    let registeredStudentUsername = keychain.get("registeredStudentUsername")
                                    let registeredStudentPassword = keychain.get("registeredStudentPassword")
                                    
                                    self.isStudentLoginSuccessful = self.studentUsernameText == registeredStudentUsername && self.studentPasswordText == registeredStudentPassword
                                    
                                    if self.isStudentLoginSuccessful {
                                        self.showNextView = .mainStudent
                                    } else {
                                        withAnimation(.easeInOut(duration: 0.05).repeatCount(4, autoreverses: true)) {
                                            shakeOffset = 6
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                                shakeOffset = 0
                                            }
                                        }
                                        performShakeAnimation()
                                    }
                                    self.buttonColorBottom = self.isStudentLoginSuccessful ? buttonColorTopSucess : buttonColorLogin
                                }) {
                                    Text("Student Login")
                                        .foregroundColor(.white)
                                        .frame(width: 125, height: 20, alignment: .center)
                                }
                                .padding()
                                .background(buttonColorBottom)
                                .cornerRadius(10)
                                .offset(x: shakeOffset)
                                
                                if showErrorMessages && errorMessages == "student_login" {
                                    Text("Incorrect Username and Password. Try again.")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                }
                                
                                //~~~~~~~~~~~~~~ END OF LOGIN BUTTON FOR STUDENT ~~~~~~~~~~~~~~~~~~~~~//
                            }
                            .padding()
                        }
                    }
                }
                
                
            }
        }
    }
              */
    */
    public func performShakeAnimation() {
        if let engine = try? CHHapticEngine() {
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [sharpness, intensity], relativeTime: 0)
            
            if let pattern = try? CHHapticPattern(events: [event], parameters: []) {
                if let player = try? engine.makePlayer(with: pattern) {
                    try? engine.start()
                    try? player.start(atTime: CHHapticTimeImmediate)
                }
                
                let shakes = 6
                let duration = 0.05
                
                DispatchQueue.global().async {
                    for _ in 0..<shakes {
                        DispatchQueue.main.async {
                            withAnimation(.default) {
                                self.shakeOffset = -10
                            }
                        }
                        Thread.sleep(forTimeInterval: duration)
                        
                        DispatchQueue.main.async {
                            withAnimation(.default) {
                                self.shakeOffset = 10
                            }
                        }
                        Thread.sleep(forTimeInterval: duration)
                    }
                    
                    DispatchQueue.main.async {
                        withAnimation(.default) {
                            self.shakeOffset = 0
                        }
                    }
                }
            }
            
        }
        
    }
}


struct LoginView_Previews: PreviewProvider {
    @State static private var showNextView: DisplayState = .login
    
    static var previews: some View {
        LoginView(showNextView: $showNextView)
    }
}
