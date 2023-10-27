//
//  ResetPasswordView.swift
//  Project190
//
//  Created by Vlad Puriy on 9/14/23.
//

import Foundation
import SwiftUI
import Combine

private var codeIn = ""

struct ForgotPasswordView: View {
    @Binding var showNextView: DisplayState
    
    @State private var viewNext: DisplayState = .pwCodeVerification
    
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            HStack{
                Button(action:{}){
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                        .font(.system(size: 19))
                        .padding(.top, 180)
                        .padding(.bottom, 100)
                }
                Spacer()
            }
            Text("Forgot Password?")
                .fontWeight(.bold)
                .font(.system(size: 35))
                .padding(.bottom, 45)
            
            Image(systemName: "questionmark")
                .padding(.bottom, 60)
                .fontWeight(.bold)
                .font(.system(size: 100))
            
            Text("Please enter your email to receive a verification code")
                .multilineTextAlignment(.center)
                .lineLimit(2, reservesSpace: true)
                .font(.body)
                .fontWeight(.bold)
            
            
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .frame(width: 370)
                .padding(.vertical, 25.0)
                .disableAutocorrection(true)
            
            Button(action: {
                print("Button was tapped")
                email = email.trimmingCharacters(in: .whitespacesAndNewlines)
                if isValidEmail(email) {
                    print("Email to send to: \(email)")
                    let code = generateRandomCode()
                    sendEmail(code: code, email: email)
                    viewNext = .pwCodeVerification
                } else {
                    alertMessage = "Invalid email format"
                    showAlert = true
                    viewNext = .emailCode
                }
                withAnimation {
                    //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                    showNextView = viewNext
                }
            }) {
                Text("Send Code")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 275, height: 20, alignment: .center)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding(.bottom, 300)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
    
    func generateRandomCode() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        codeIn = String((0..<5).map{ _ in letters.randomElement()! });
        return codeIn
    }
    
    
    func sendEmail(code: String, email: String) {
        guard let url = URL(string: "https://api.smtp2go.com/v3/email/send") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("api-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", forHTTPHeaderField: "Key") // Replace with your API key
        
        let body: [String: Any] = [
            "api_key": "api-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", // Your API key
            "to": ["<\(email)>"], // The recipient's email address, formatted correctly
            "sender": "appaused.service@gmail.com", // Your email address
            "subject": "Your Verification Code",
            "text_body": "Your verification code is: \(code)",
            "html_body": "<p>Your verification code is: \(code)</p>"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending email: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
                if let data = data, let body = String(data: data, encoding: .utf8) {
                    print("Response body: \(body)")
                }
            }
        }
        
        task.resume()
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    
    @State static private var showNextView: DisplayState = .emailCode
    
    static var previews: some View {
        ForgotPasswordView(showNextView: $showNextView)
    }
}

internal struct ForgotPassword {
    static let shared = ForgotPassword()
    
    public func grabRandCode() -> String {
        return codeIn
    }
}
