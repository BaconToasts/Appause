//
//  PWCodeVerification.swift
//  Project190
//
//  Created by Alec on 9/15/23.
//

import Foundation
import SwiftUI
import Combine

struct PWCodeVerificationView: View
{
    //Add this binding state for transitions from view to view
    @Binding var showNextView: DisplayState
    
    @State private var resetCode: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var codeIn = ForgotPassword.shared.grabRandCode()
    
    var body: some View
    {
        VStack
        {
            HStack{
                Button(action:{}){
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                        .font(.system(size: 19))
                }
                .padding(.top, 150)
                .padding(.trailing, 335)
                .padding(.bottom, 100)
            }
            Text("Verify Email")
                .padding()
                .fontWeight(.bold)
                .font(.system(size: 30))
                .padding(.bottom, 30)
            
            Image(systemName: "magnifyingglass")
                .fontWeight(.bold)
                .font(.system(size:100))
                .padding(.bottom, 50)
            
            Text("To verify yourself please enter the reset code.")
                .font(.body)
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
            
            TextField("Insert Reset Code ", text:$resetCode)
                .padding()
                .disabled(false)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .frame(width: 370)
                .padding(.vertical, 25.0)
            
            Button(action: {
                withAnimation {
                    showNextView = .resetPassword
                }
                if isSameCode(resetCode) {
                    showNextView = .resetPassword
                } else {
                    alertMessage = "Invalid reset code"
                    showAlert = true
                }
            }){
                Text("Submit")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 275, height: 20, alignment: .center)
                    .padding()
                    .background(Color.black)
                    .border(Color.black, width: 5)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("ERROR"), message: Text(alertMessage), dismissButton: .default(Text("OKAY")))
            }
        }
        .padding(.bottom, 300)
        .cornerRadius(100)
        }
        
    func isSameCode(_ code: String) -> Bool {
            return code == codeIn
        }
    }

struct PWCodeVerificationView_Previews: PreviewProvider {
    @State static private var showNextView: DisplayState = .pwCodeVerification

    static var previews: some View {
        PWCodeVerificationView(showNextView: $showNextView)
    }
}
