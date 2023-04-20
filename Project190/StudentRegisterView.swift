//
//  StudentRegisterView.swift
//  Project190
//
//  Created by Mark Zhang on 4/19/23.
//

import SwiftUI

struct StudentRegisterView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passConfirm: String = ""
    
    var body: some View {
        VStack{
            
            TextField(
                "First Name",
                text: $firstName
            )
            .multilineTextAlignment(.leading)
            .textFieldStyle(.roundedBorder)
            .padding([.trailing, .leading], 50)
            .padding(.bottom, 5)
            
            TextField(
                "Last Name",
                text: $lastName
            )
            .multilineTextAlignment(.leading)
            .textFieldStyle(.roundedBorder)
            .padding([.trailing, .leading], 50)
            .padding(.bottom, 5)
            
            TextField(
                "Email Address",
                text: $email
            )
            .multilineTextAlignment(.leading)
            .textFieldStyle(.roundedBorder)
            .padding([.trailing, .leading], 50)
            .padding(.bottom, 5)
            
            TextField(
                "Password",
                text: $password
            )
            .multilineTextAlignment(.leading)
            .textFieldStyle(.roundedBorder)
            .padding([.trailing, .leading], 50)
            .padding(.bottom, 5)
            
            TextField(
                "Confirm Password",
                text: $passConfirm
            )
            .multilineTextAlignment(.leading)
            .textFieldStyle(.roundedBorder)
            .padding([.trailing, .leading], 50)
            .padding(.bottom, 10)
            
            Button(action: {
                //functionality goes here
            }) {
                Text("+ Register")
                    .padding()
                    .fontWeight(.bold)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(100)
                    .padding(.leading, 200)
            }
        }
    }
}

struct StudentRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        StudentRegisterView()
    }
}
