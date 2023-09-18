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
    
    var body: some View
    {
        VStack
        {
            Button(action: {
                withAnimation {
                    showNextView = .mainStudent} //main student is placeholder for proper connections
            }){
                Text("MAIN / PASSWORD RESET")
                    .padding()
                    .fontWeight(.bold)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .frame(width: 300,
                           height: 20,
                           alignment: .center)
            }
            .padding()
            .background(Color.black)
            .border(Color.black, width: 5)
            .cornerRadius(100)
            .padding(.bottom, 30)
            
            Text("Reset Verification Code")
                .font(.title)
                .padding(.top, 25)
            
            
            TextField("Insert Reset Code ", text:$resetCode)
                .padding(25.0)
                .frame(width: 250.0, height: 100.0)
                .disabled(false)
                .textFieldStyle(.roundedBorder)
            
            Button(action: {
                withAnimation {
                    showNextView = .mainStudent //main student is placeholder for proper connections
                    
                }
                if isValidCode(resetCode) {
                } else {
                    alertMessage = "Invalid reset code"
                    showAlert = true
                }
            }) {
                /*.alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }*/
            }
                .padding()
                .frame(width: 300.0, height: 30.0)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(100)
                
            }
            .padding(.bottom, 400)
            .cornerRadius(100)
        }
        
        func isValidCode(_ code: String) -> Bool {
            let codeFormat = "[A-Z0-9a-z]}"
            let codePredicate = NSPredicate(format:"SELF MATCHES %@", codeFormat)
            return codePredicate.evaluate(with: code)
        }
    }

struct PWCodeVerificationView_Previews: PreviewProvider {
    @State static private var showNextView: DisplayState = .mainStudent

    static var previews: some View {
        StudentConnectCodeView(showNextView: $showNextView)
    }
}
