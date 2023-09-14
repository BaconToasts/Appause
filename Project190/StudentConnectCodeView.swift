//
//  ContentView.swift
//  Student Connect Code
//
//  Created by user123 on 4/6/23.
//

import SwiftUI

struct StudentConnectCodeView: View
{
    //Add this binding state for transitions from view to view
    @Environment(\.dismiss) private var dismiss
    
    @State private var connectCode: String = ""
    
    var body: some View
    {
        VStack
        {
            Button(action: { dismiss()}){
                Text("MAIN / CONNECT CODE")
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
            
            Text("Connect Code")
                .font(.title)
                .padding(.top, 25)
            
            
            TextField("Insert Connect Code Here: ", text:$connectCode)
            .padding(25.0)
            .frame(width: 250.0, height: 100.0)
            .disabled(false)
            .textFieldStyle(.roundedBorder)
            
            Button("Submit Connect Code"){/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/}
            .padding()
            .frame(width: 300.0, height: 30.0)
            .background(.black)
            .foregroundColor(.white)
            .cornerRadius(100)
            
        }
        .padding(.bottom, 400)
        .cornerRadius(100)
    }
}

struct StudentConnectCodeView_Previews: PreviewProvider {
    static var previews: some View {
        StudentConnectCodeView()
    }
}
