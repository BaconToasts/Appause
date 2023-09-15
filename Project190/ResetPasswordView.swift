//
//  ResetPasswordView.swift
//  Project190
//
//  Created by Luis Campos on 9/12/23.
//

import SwiftUI
import KeychainSwift

struct ResetPasswordView: View{
    @Binding var showNextView: DisplayState
    @State private var displayText:String = "Please enter your new password"
    @State private var newPassword:String = ""
    @State private var confirmNewPassword:String = ""
    @State private var passCheck = false
    @State private var nextView: DisplayState = .login
    @State private var showPassword = false
    private let keychain = KeychainSwift()//LoginView.keychain
    var body: some View{
        VStack{
            Button(action:{}){
                Text("MAIN/PASSWORD RESET")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width:300, height:20, alignment: .center)
            }
            .padding()
            .background(Color.black)
            .cornerRadius(100)
            .padding(.bottom, 200)
            
            //Displaying the prompt for creating a new password
            Text(displayText)
                .fontWeight(.bold)
            
            //This block of code creates the necessary text field to enter in a new password
            TextField("New Password: ", text:$newPassword)
                .padding([.trailing, .leading], 50)
                .padding(.bottom, 10)
                .padding(.top, 50)
                .multilineTextAlignment(.leading)
                .textFieldStyle(.roundedBorder)
            
            /*These lines of code are necessary for creating the text field for the
            user to retype the brand new password they typed up in the previous text field.*/
            TextField("Confirm New Password: ", text:$confirmNewPassword)
                .padding([.trailing, .leading], 50)
                .multilineTextAlignment(.leading)
                .textFieldStyle(.roundedBorder)
            
            /*Finally this section of code is for the confirmation button and it checks
             to see if both of the passwords that the user types into the fields are the same*/
            Button(action:{
                let npass = newPassword
                let cNPass = confirmNewPassword
                let passCheck = npass==cNPass
                if passCheck{
                    displayText="Correct New Password"
                    nextView = .login
                }
                else{
                    displayText="Incorrect New Password"
                    nextView = .resetPassword
                }
                withAnimation{showNextView = nextView}
            }){
                Text("Confirm")
            }
            .padding()
            .border(Color.black, width: 5)
            .cornerRadius(6)
            .padding(.top,200)
        }
    }
}
struct ResetPasswordView_Previews: PreviewProvider{
    @State static private var showNextView:DisplayState = .resetPassword
    static var previews: some View{
        ResetPasswordView(showNextView: $showNextView)
    }
}
