//
//  ResetPasswordView.swift
//  Project190
//
//  Created by Luis Campos on 9/12/23.
//

import SwiftUI
import KeychainSwift

struct ResetPasswordView: View{
    @Binding var showNextView: DisplayState // Define a binding property
    
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
    
    struct TextFieldEyeIcon: View{
        var placeholderText: String
        @Binding var userInput: String
        var isFieldSecure: Bool
        @Binding var visibility: String
        
        var body: some View{
            HStack{
                if(isFieldSecure==true){
                    SecureField(placeholderText, text: $userInput)
                }
                else if(isFieldSecure==false){
                    TextField(placeholderText, text: $userInput)
                }
                Button(action:{visibility = isFieldSecure ? "visible" :"hidden"}){
                    Image(systemName: isFieldSecure ? "eye" : "eye.slash")
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .frame(width: 370)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(TextInputAutocapitalization.never)
        }
    }
    var body: some View{
        VStack{
            
            HStack{
                Button(action:{}){
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                        .font(.system(size:20))
                }
                .padding(.top, 150)
                .padding(.trailing, 350)
                .padding(.bottom, 100)
            }
            
            Text("Create a new password")
                .fontWeight(.bold)
                .font(.system(size:30))
                .padding(.bottom, 20)
            
            Image(systemName: "pencil.and.outline")
                .fontWeight(.bold)
                .font(.system(size: 100))
            
            //Displaying the prompt for creating a new password
            Text(displayText)
                .fontWeight(.bold)
                .padding(.top, 5)
                .padding(.bottom, 10)
            
            /*These if else statements are supposed to help display the text field entry
             for the users new password and depending on if the user clicks on the show
             button it will display the new password or hide it if they click hide.*/
            if(newPasswordViewStatus == "visible"){
                HStack{
                    TextFieldEyeIcon(placeholderText: "New Password", userInput: $newPassword, isFieldSecure: false, visibility: $newPasswordViewStatus)
                }
                .padding(.bottom, 10)
            }
            else{
                HStack{
                    TextFieldEyeIcon(placeholderText: "New Password", userInput: $newPassword, isFieldSecure: true, visibility: $newPasswordViewStatus)
                }
                .padding(.bottom, 10)
            }
            /*These if else statements are supposed to help display the text field entry
             for the users to confirm their new password and depending on if the user clicks
             on the show button it will display the new password or hide it if they click hide.*/
            if(confirmNewPasswordViewStatus == "visible"){
                HStack{
                    TextFieldEyeIcon(placeholderText: "Confirm New Password", userInput: $confirmNewPassword, isFieldSecure: false, visibility: $confirmNewPasswordViewStatus)
                }
                .padding(.bottom, 10)
            }
            else{
                HStack{
                    TextFieldEyeIcon(placeholderText: "Confirm New Password", userInput: $confirmNewPassword, isFieldSecure: true, visibility: $confirmNewPasswordViewStatus)
                }
                .padding(.bottom, 10)
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
            .padding()
            .padding(.bottom, 300)
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider{
    @State static private var showNextView: DisplayState = .resetPassword
    
    static var previews: some View{
        ResetPasswordView(showNextView: $showNextView)
    }
}
