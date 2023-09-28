//
//  TeacherRegisterView.swift
//  Project190
//
//  Created by Mark Zhang on 9/16/23.
//

import SwiftUI
import Foundation //used for regex verification
import KeychainSwift // used to save registration data


struct TeacherRegisterView: View {
    //Add this binding state for transitions from view to view
    @Binding var showNextView: DisplayState
    
    //variables used to store registration data before being sent to the keychain
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passConfirm: String = ""
    
    //String variable used in error messages
    @State private var registerError: String = " "
    
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
            
            Text("Teacher Registration")
                .font(.custom("large", size: 25))
                .padding()
            
            Text(registerError)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            TextField(
                "First Name",
                text: $firstName
            )
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .multilineTextAlignment(.leading)
            .cornerRadius(10)
            .padding([.trailing, .leading], 50)
            .padding(.bottom, 5)
            
            TextField(
                "Last Name",
                text: $lastName
            )
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .multilineTextAlignment(.leading)
            .cornerRadius(10)
            .padding([.trailing, .leading], 50)
            .padding(.bottom, 5)
            
            TextField(
                "Email Address",
                text: $email
            )
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .multilineTextAlignment(.leading)
            .cornerRadius(10)
            .padding([.trailing, .leading], 50)
            .padding(.bottom, 5)
            
            SecureField(
                "Password",
                text: $password
            )
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .multilineTextAlignment(.leading)
            .cornerRadius(10)
            .padding([.trailing, .leading], 50)
            .padding(.bottom, 5)
            
            SecureField(
                "Confirm Password",
                text: $passConfirm
            )
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .multilineTextAlignment(.leading)
            .cornerRadius(10)
            .padding([.trailing, .leading], 50)
            .padding(.bottom, 5)
            
            Button(action: {
                if (firstName == "" || lastName == "" || email == "" || password == "" || passConfirm == ""){
                    registerError = "Please fill in all of the fields."
                }
                else if (validateEmail(email) == false){
                    registerError = "Please enter a valid email address."
                }
                else if (password != passConfirm){
                    registerError = "Passwords do not match. Try again."
                }
                else{
                    //resets the error message if there is one
                    registerError = ""
                    
                    //adds information into the keychain
                    keychain.set(email, forKey: "teacherUserKey")
                    keychain.set(password, forKey: "teacherPassKey")
                    keychain.set(firstName, forKey: "teacherFirstNameKey")
                    keychain.set(lastName, forKey: "teacherLastNameKey")
                    
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
        }
    }
    
    func validateEmail(_ email: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: [.caseInsensitive])
        return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil
    }
}

struct TeacherRegisterView_Previews: PreviewProvider {
    @State static private var showNextView: DisplayState = .teacherRegister
    
    static var previews: some View {
        TeacherRegisterView(showNextView: $showNextView)
    }
}

