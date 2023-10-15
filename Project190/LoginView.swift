import SwiftUI
import MessageUI
import KeychainSwift
import Combine
import CoreHaptics
import LocalAuthentication

var currentLoggedInUser: String? = nil

private var isTeacherLogin = false
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
    @State private var isFaceIDAuthenticated = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State var emailFor2FA: String = ""
    @State private var showErrorMessages = false
    @State private var errorMessages = ""
    @State private var shakeOffset: CGFloat = 0.0
    @Binding var showNextView: DisplayState
    @State var buttonNameTop = "Teacher Login"
    @State var buttonColorTopIdle = Color.gray                 // Color.black (original value)
    @State var buttonColorTopActive = Color.black                // Color.blue (original value)
    @State var buttonColorLogin = Color.black                    // Color.blue (original value)
    @State var buttonNameBottom = "Student Login"
    @State var buttonColorBottomIdle = Color.gray              // Color.black  (original value)
    @State var buttonColorBottomActive = Color.black            // Color.blue  (original value)
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
    
    @State var studentPassVisibility: String = ""
    @State var teacherPassVisibility: String = ""
    
    var body: some View {
        VStack {
            if !show2FAInput {
                
                Spacer()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                Text("Appause")
                    .fontWeight(.bold)
                    .font(.system(size: 36))
                
                Spacer()
                
                HStack{
                    Button(action: {
                        self.showCodeField = false
                        self.showTextFields.toggle()
                        self.buttonColorTop = self.showTextFields ? buttonColorTopActive: buttonColorTopIdle
                        self.buttonColorBottom = self.showCodeField ? buttonColorTopActive : buttonColorTopIdle
                        if(buttonColorTop == buttonColorTopIdle){
                            buttonColorTop = Color.black
                            buttonColorBottom = Color.black
                        }
                    }) {
                        VStack{
                            Text(buttonNameTop)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 150, height: 20, alignment: .center)
                            Image(systemName: "graduationcap")
                                .fontWeight(.bold)
                                .imageScale(.large)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(buttonColorTop)
                    .cornerRadius(10)
                    
                    //Spacer()
                    
                    Button(action: {
                        self.showTextFields = false
                        self.showCodeField.toggle()
                        self.buttonColorTop = self.showTextFields ? buttonColorBottomActive: buttonColorBottomIdle
                        self.buttonColorBottom = self.showCodeField ? buttonColorBottomActive : buttonColorBottomIdle
                        if(buttonColorBottom == buttonColorBottomIdle){
                            buttonColorTop = Color.black
                            buttonColorBottom = Color.black
                        }
                    }) {
                        VStack{
                            Text(buttonNameBottom)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 150, height: 20, alignment: .center)
                            Image(systemName: "square.and.pencil")
                                .padding(4)
                                .fontWeight(.bold)
                                .imageScale(.large)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(buttonColorBottom)
                    .cornerRadius(10)
                }
                
                if showTextFields || showCodeField {
                    VStack {
                        HStack {
                            Text(showTextFields ? "Teacher Username:" : "Student Username:")
                                .fontWeight(.bold)
                            TextField("Enter Username", text: showTextFields ? $usernameText : $studentUsernameText)
                                .padding()
                                .background(textFieldOpacity)
                                .cornerRadius(10)
                                .frame(width: 180)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                        .padding(.trailing, 40)
                        HStack {
                            Text(showTextFields ? "Teacher Password:" : "Student Password:")
                                .fontWeight(.bold)
                            if(buttonColorTop == Color.black){           // Color.blue (original parameter)
                                if(teacherPassVisibility=="visible"){
                                    HStack{
                                        TextField("Enter Password", text: $passwordText)
                                            .padding()
                                            .background(textFieldOpacity)
                                            .cornerRadius(10)
                                            .frame(width: 180)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                        Button(action:{teacherPassVisibility = "hidden"}){
                                            Image(systemName: "eye.slash")
                                                .foregroundColor(Color.black)
                                                .fontWeight(.bold)
                                        }
                                    }
                                }
                                else{
                                    HStack{
                                        SecureField("Enter Password", text: $passwordText)
                                            .padding()
                                            .background(textFieldOpacity)
                                            .cornerRadius(10)
                                            .frame(width: 180)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                        Button(action:{teacherPassVisibility = "visible"}){
                                            Image(systemName: "eye")
                                                .foregroundColor(Color.black)
                                                .fontWeight(.bold)
                                        }
                                    }
                                }
                            }
                            else{
                                if(studentPassVisibility=="visible"){
                                    HStack{
                                        TextField("Enter Password", text: $studentPasswordText)
                                            .padding()
                                            .background(textFieldOpacity)
                                            .cornerRadius(10)
                                            .frame(width: 180)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                        Button(action:{studentPassVisibility = "hidden"}){
                                            Image(systemName: "eye.slash")
                                                .foregroundColor(Color.black)
                                                .fontWeight(.bold)
                                        }
                                    }
                                }
                                else{
                                    HStack{
                                        SecureField("Enter Password", text: $studentPasswordText)
                                            .padding()
                                            .background(textFieldOpacity)
                                            .cornerRadius(10)
                                            .frame(width: 180)
                                        Button(action:{studentPassVisibility = "visible"}){
                                            Image(systemName: "eye")
                                                .foregroundColor(Color.black)
                                                .fontWeight(.bold)
                                        }
                                    }
                                }
                            }
                        }
                        HStack {
                            Button(action: {
                                let registeredUsername = showTextFields ? keychain.get("teacherUserKey") : keychain.get("studentUserKey")
                                let registeredPassword = showTextFields ? keychain.get("teacherPassKey") : keychain.get("studentPassKey")
                                // if(registeredUsername != nil && registeredPassword != nil){
                                
                                // }
                                //else{
                                withAnimation {
                                    showNextView = .selectRegistration
                                }
                                //}
                            }) {
                                Text("Register")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 75, height: 20, alignment: .center)
                            }
                            .padding()
                            .background(Color.black)
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
                                
                                let username = (showTextFields ? usernameText : studentUsernameText).lowercased()
                                let password = (showTextFields ? passwordText : studentPasswordText).lowercased()
                                
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
                                
                                if (buttonColorTop == buttonColorTopActive){
                                    self.buttonColorTop = isSuccessful ? buttonColorTopSucess : buttonColorLogin
                                }
                                
                                if (buttonColorBottom == buttonColorBottomActive){
                                    self.buttonColorBottom = isSuccessful ? buttonColorTopSucess : buttonColorLogin
                                }
                                
                            }) {
                                Text("Login")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 130, height: 20, alignment: .center)
                            }
                            .padding()
                            .background(Color.black)            // Color.blue (original parameter)
                            .cornerRadius(10)
                            .offset(x: shakeOffset)
                            .padding(.leading, 10)
                            .padding()
                            Button(action: authenticateWithFaceID) {
                                HStack {
                                    Image(systemName: "faceid")
                                        .imageScale(.large)
                                        .foregroundColor(.white)
                                        .foregroundColor(.white)
                                }
                                .frame(width: 20, height: 20, alignment: .center)
                            }
                            .padding()
                            .background(Color.black)
                            .cornerRadius(100)
                            .padding(.leading, -17)
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                            }
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
            Spacer()
            
            Image("")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Spacer()
            
            
            
            
            //Spacer()
        }
        .onAppear {
            currentLoggedInUser = nil
        }
    }
    
    
    func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isFaceIDAuthenticated = true
                        autofillCredentials()
                    } else {
                        showAlert(title: "Authentication Failed", message: "Sorry! Could not authenticate using Face ID.")
                    }
                }
            }
        } else {
            showAlert(title: "Face ID Unavailable", message: "Sorry! Your device does not support Face ID.")
        }
    }
    
    func autofillCredentials() {
        if isFaceIDAuthenticated {
            if showTextFields {  // Teacher Login
                usernameText = keychain.get("teacherUserKey") ?? ""
                passwordText = keychain.get("teacherPassKey") ?? ""
            } else if showCodeField {  // Student Login
                studentUsernameText = keychain.get("studentUserKey") ?? ""
                studentPasswordText = keychain.get("studentPassKey") ?? ""
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
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
internal struct Login{
    @State static private var showNextView: DisplayState = .login
    static let logV = Login()
    public func getIsTeacher() -> Bool{
        return isTeacherLogin
    }
}
