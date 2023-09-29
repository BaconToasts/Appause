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
    @State private var recentPassCheck = false
    @State private var nextView: DisplayState = .login
    @State private var newPasswordViewStatus: String = ""
    @State private var confirmNewPasswordViewStatus: String = ""
    @State private var studentDiffPassword = false
    @State private var teacherDiffPassword = false
    @State private var confirmColor = Color.green
    @State private var userType = Login.logV.getIsTeacher()
    private let kc = KeychainSwift()
    
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
            
            /*These if else statements are supposed to help display the text field entry
             for the users new password and depending on if the user clicks on the show
             button it will display the new password or hide it if they click hide.*/
            if(newPasswordViewStatus == "visible"){
                HStack{
                    TextField("New Password: ", text: $newPassword)
                        .padding(.leading, 20)
                        .padding(.bottom, 10)
                        .padding(.top, 50)
                        .multilineTextAlignment(.leading)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(TextInputAutocapitalization.never)
                    Button(action: {newPasswordViewStatus = "hidden"}){
                        Image(systemName: "eye.slash")
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                            .padding(.top, 40)
                            .padding(.trailing, 50)
                    }
                }
            }
            else{
                HStack{
                    SecureField("New Password: ", text:$newPassword)
                        .padding(.leading, 20)
                        .padding(.bottom, 10)
                        .padding(.top, 50)
                        .multilineTextAlignment(.leading)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(TextInputAutocapitalization.never)
                    Button(action:{newPasswordViewStatus = "visible"}){
                        Image(systemName: "eye")
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                            .padding(.top, 40)
                            .padding(.trailing, 50)
                    }
                }
            }
            /*These if else statements are supposed to help display the text field entry
             for the users to confirm their new password and depending on if the user clicks
             on the show button it will display the new password or hide it if they click hide.*/
            if(confirmNewPasswordViewStatus == "visible"){
                HStack{
                    TextField("Confirm New Password: ", text: $confirmNewPassword)
                        .padding(.leading, 20)
                        .padding(.bottom, 20)
                        .multilineTextAlignment(.leading)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(TextInputAutocapitalization.never)
                    Button(action: {confirmNewPasswordViewStatus = "hidden"}){
                        Image(systemName: "eye.slash")
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                            .padding(.trailing, 50)
                    }
                }
            }
            else{
                HStack{
                    SecureField("Confirm New Password: ", text: $confirmNewPassword)
                        .padding(.leading, 20)
                        .padding(.bottom, 20)
                        .multilineTextAlignment(.leading)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(TextInputAutocapitalization.never)
                    Button(action: {confirmNewPasswordViewStatus = "visible"}){
                        Image(systemName: "eye")
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                            .padding([.bottom, .trailing], 20)
                            .padding(.trailing, 30)
                    }
                }
            }
            /*Finally this section of code is for the confirmation button and it checks
             to see if both of the passwords that the user types into the fields are the same*/
            Button(action:{
                let npass = newPassword
                let cNPass = confirmNewPassword
                let passCheck = npass==cNPass
                let studentName = kc.get("studentUserKey")
                /*These variables are supposed to store whether or not if the student's new password
                 or the teacher's new password matches their previous password. If it does then it will
                 remain on the reset page until they type in a new password*/
                studentDiffPassword = (npass != kc.get("studentPassKey"))
                teacherDiffPassword = (npass != kc.get("teacherPassKey"))
                if(npass != "" && cNPass != ""){
                    if(userType == false){
                        if(passCheck && studentDiffPassword == true){
                            displayText="Correct New Password"
                            kc.set(npass, forKey: "studentPassKey")
                            nextView = .login
                            confirmColor = Color.green
                        }
                        else if (passCheck == true && studentDiffPassword == false){
                            displayText = "Enter Unique Password"
                            nextView = .resetPassword
                            confirmColor = Color.red
                        }
                        else if (passCheck == false){
                            displayText = "Enter the same new password"
                            nextView = .resetPassword
                            confirmColor = Color.red
                        }
                    }
                    else{
                        if(passCheck && teacherDiffPassword == true){
                            displayText="Correct New Password"
                            kc.set(npass, forKey: "teacherPassKey")
                            nextView = .login
                            confirmColor = Color.green
                        }
                        else if (passCheck == true && teacherDiffPassword == false){
                            displayText = "Enter Unique Password"
                            nextView = .resetPassword
                            confirmColor = Color.red
                        }
                        else if (passCheck == false){
                            displayText = "Enter the same new password"
                            nextView = .resetPassword
                            confirmColor = Color.red
                        }
                    }
                }
                else{
                    displayText = "No password was entered"
                    nextView = .resetPassword
                    confirmColor = Color.red
                }
                withAnimation{showNextView = nextView}
            }){
                Text("Confirm")
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
            }
            .padding()
            .background(confirmColor)
            .cornerRadius(100)
            .padding(.top,180)
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider{
    @State static private var showNextView: DisplayState = .resetPassword
    
    static var previews: some View{
        ResetPasswordView(showNextView: $showNextView)
    }
}
