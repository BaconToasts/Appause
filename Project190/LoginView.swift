import SwiftUI
import MessageUI
import KeychainSwift
import Combine
import CoreHaptics

var currentLoggedInUser: String? = nil

struct LoginView: View {
    public var keychain = KeychainSwift()
    @State private var show2FAInput = false
   /* var isTwoFactorEnabled: Bool {
            if let user = currentLoggedInUser {
                return UserDefaults.standard.bool(forKey: "\(user)_isTwoFactorEnabled")
            }
            return false
        }
    */
    var isTwoFactorEnabled: Bool {
        if let user = currentLoggedInUser {
            let accountType = isTeacherLogin ? "teacher" : "student"
            return UserDefaults.standard.bool(forKey: "\(user)_\(accountType)IsTwoFactorEnabled")
        }
        return false
    }

    @State var emailFor2FA: String = ""
    @State private var showErrorMessages = false
    @State private var errorMessages = ""
    @State private var shakeOffset: CGFloat = 0.0
    @Binding var showNextView: DisplayState
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
    @State private var isTeacherLogin = false

    var body: some View {
        VStack {
            if !show2FAInput {
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
                            Button(action: {
                                withAnimation {
                                    showNextView = .selectRegistration
                                }
                            }) {
                                Text("Register")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 75, height: 20, alignment: .center)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.9))
                            .cornerRadius(100)
                            .padding(.leading, 20)
                            
                            if showErrorMessages && errorMessages == "registration" {
                                Text("Incorrect Username and Password. Try again.")
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                            
                            Button(action: {
                                let registeredUsername = showTextFields ? keychain.get("teacherUserKey") : keychain.get("studentUserKey")
                                let registeredPassword = showTextFields ? keychain.get("teacherPassKey") : keychain.get("studentPassKey")
                                
                                let username = showTextFields ? usernameText : studentUsernameText
                                let password = showTextFields ? passwordText : studentPasswordText
                                
                                let isSuccessful = username == registeredUsername && password == registeredPassword
                                
                                if isSuccessful {
                                    isTeacherLogin = showTextFields
                                    currentLoggedInUser = username
                                    if isTwoFactorEnabled {
                                        emailFor2FA = username
                                        show2FAInput = true
                                    } else {
                                        showNextView = isTeacherLogin ? .mainTeacher : .mainStudent
                                    }
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
                                    .frame(width: 130, height: 20, alignment: .center)
                            }
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .offset(x: shakeOffset)
                            .padding(.leading, 30)
                            .padding()
                        }
                    }
                }
            } else {
                if show2FAInput {
                    TwoFactorAuthView(showNextView: $showNextView, email: emailFor2FA, onVerificationSuccess: {
                        show2FAInput = false
                        showNextView = isTeacherLogin ? .mainTeacher : .mainStudent // Navigate based on the type of login
                    }, show2FAInput: $show2FAInput)
                }
            }
        }
        .onAppear {
            currentLoggedInUser = nil
        }
    }
    
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
