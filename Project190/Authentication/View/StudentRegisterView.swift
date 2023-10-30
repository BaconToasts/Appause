//
//  StudentRegisterView.swift
//  Project190
//
//  Created by Mark Zhang on 4/19/23.
//  Updated by Luis Campos on 10/5/23.

import SwiftUI
import Foundation //used for regex verification
import KeychainSwift // used to save registration data


struct StudentRegisterView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    //Add this binding state for transitions from view to view
    @Binding var showNextView: DisplayState
    
    //variables used to store registration data before being sent to the keychain
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    //@State private var email: String = ""
    //@State private var password: String = ""
    
    //String variable used in error messages
    @State private var registerError: String = " "
    
    @State private var passwordStatus: String = ""
    @State private var confirmStatus: String = ""
    
    //keychain variable
    let keychain = KeychainSwift()
    
    var body: some View {
        VStack{
            
            Button(action: {
                withAnimation {
                    //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                    showNextView = .login}
            }) {
                Text(" < Return to Login")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(100)
                    .padding(.trailing, 130)
                    .padding(.bottom, 30)
            }
            Text("Student Registration")
                .font(.custom("large", size: 25))
                .padding()
            
            Text(registerError)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            TextField(
                "Full Name",
                text: $fullname
            )
            .disableAutocorrection(true)
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .multilineTextAlignment(.leading)
            .cornerRadius(10)
            .padding([.trailing, .leading], 50)
            .padding(.bottom, 5)

            /*
            TextField(
                "Last Name",
                text: $lastName
            )
            .disableAutocorrection(true)
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .multilineTextAlignment(.leading)
            .cornerRadius(10)
            .padding([.trailing, .leading], 50)
            .padding(.bottom, 5)
             */
            
            TextField(
                "Email Address",
                text: $email
            )
            .disableAutocorrection(true)
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .multilineTextAlignment(.leading)
            .cornerRadius(10)
            .padding([.trailing, .leading], 50)
            .padding(.bottom, 10)
            
            if(passwordStatus == "visible"){
                HStack{
                    TextField("Password", text: $password)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .multilineTextAlignment(.leading)
                        .cornerRadius(10)
                        .padding(.leading, 50)
                        .padding(.bottom, 5)
                    Button(action:{passwordStatus="hidden"}){
                        Image(systemName:"eye.slash")
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                            .padding(.trailing, 13)
                    }
                }
                .padding(.bottom, 5)
            }
            else{
                HStack{
                    SecureField("Password", text: $password)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .multilineTextAlignment(.leading)
                        .cornerRadius(10)
                        .padding(.leading, 50)
                        .padding(.bottom, 5)
                    Button(action:{passwordStatus="visible"}){
                        Image(systemName:"eye")
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                            .padding(.trailing, 13)
                    }
                }
                .padding(.bottom, 5)
            }
            if(confirmStatus=="visible"){
                HStack{
                    TextField("Confirm Password", text: $confirmPassword)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .multilineTextAlignment(.leading)
                        .cornerRadius(10)
                        .padding(.leading, 50)
                        .padding(.bottom, 5)
                    Button(action:{confirmStatus="hidden"}){
                        Image(systemName:"eye.slash")
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                            .padding(.trailing, 13)
                    }
                }
                .padding(.bottom, 5)
            }
            else{
                HStack{
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .multilineTextAlignment(.leading)
                        .cornerRadius(10)
                        .padding(.leading, 50)
                        .padding(.bottom, 5)
                    Button(action:{confirmStatus="visible"}){
                        Image(systemName:"eye")
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                            .padding(.trailing, 13)
                    }
                }
                .padding(.bottom, 5)
            }
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                }
            } label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 95, height: 48)
            }
            .background(Color(.black))
            .cornerRadius(10)
            .padding(.top, 24)
            
            /*
            Button(action: {
                if (firstName == "" || lastName == "" || email == "" || password == "" || confirmPassword == ""){
                    registerError = "Please fill in all of the fields."
                }
                else if (validateEmail(email) == false){
                    registerError = "Please enter a valid email address."
                }
                else if (password != confirmPassword){
                    registerError = "Passwords do not match. Try again."
                }
                else{
                    registerError = " " //resets the error message if there is one
                    
                    //adds information into the keychain
                    keychain.set(email.lowercased(), forKey: "studentUserKey")
                    keychain.set(password, forKey: "studentPassKey")
                    keychain.set(firstName, forKey: "studentFirstNameKey")
                    keychain.set(lastName, forKey: "studentLastNameKey")
                    
                    withAnimation {
                        //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                        showNextView = .login
                    }
                }
            }) {
                Text("+ Register")
                    .padding()
                    .fontWeight(.bold)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(100)
                    .padding(.leading, 200)
                    .padding(.bottom, 100)
            }
            */
        }
    }
    
    func validateEmail(_ email: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: [.caseInsensitive])
        return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil
    }
}

// MARK: - AuthenticationFormProtocol

extension StudentRegisterView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
    }
}

struct StudentRegisterView_Previews: PreviewProvider {
    @State static private var showNextView: DisplayState = .studentRegister
    
    static var previews: some View {
        StudentRegisterView(showNextView: $showNextView)
    }
}
