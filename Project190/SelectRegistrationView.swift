//
//  SelectRegistrationView.swift
//  Project190
//
//  Created by Mark Zhang on 9/28/23.
//

import SwiftUI
import KeychainSwift

struct SelectRegistrationView: View {
    @Binding var showNextView: DisplayState
    @State private var registerError: String = " "
    
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
                    .padding(.bottom, 38)
            }
            Text("Are you a student or a teacher?")
                .font(.custom("large", size: 25))
                .padding([.top, .bottom], 50)
            
            Text(registerError)
                .fontWeight(.bold)
                .foregroundColor(.red)
            HStack{
                Button(action: {
                    let registeredUsername = keychain.get("teacherUserKey")
                    let registeredPassword = keychain.get("teacherPassKey")
////                    if(registeredUsername != nil && registeredPassword != nil){
//                        registerError = "There is already a registered teacher."
//                    }
//                    else{
                        withAnimation {
                            //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                            showNextView = .teacherRegister}
//                    }
                }) {
                    Text("I am a Teacher")
                        .font(.custom("large", size: 25))
                        .frame(width: 140, height: 140, alignment: .center)
                        .background(Color.white.opacity(0.9))
                        .frame(width: 120, height: 120, alignment: .center)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding(.trailing, 20)
                }
                Button(action: {
                    let registeredUsername = keychain.get("studentUserKey")
                    let registeredPassword = keychain.get("studentPassKey")
//                    if(registeredUsername != nil && registeredPassword != nil){
//                        registerError = "There is already a registered student."
//                    }
//                    else{
                        withAnimation {
                            //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                            showNextView = .studentRegister}
 //                   }
                }) {
                    Text("I am a Student")
                        .font(.custom("large", size: 25))
                        .frame(width: 140, height: 140, alignment: .center)
                        .background(Color.white.opacity(0.9))
                        .frame(width: 120, height: 120, alignment: .center)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
            .padding(.bottom, 200)
        }
    }
}

struct SelectRegistrationView_Previews: PreviewProvider {
    @State static private var showNextView: DisplayState = .selectRegistration
    
    static var previews: some View {
        SelectRegistrationView(showNextView: $showNextView)
    }
}
