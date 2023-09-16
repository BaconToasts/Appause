//
//  Teacher-ConnectCodeView.swift
//  Project190
//
//  Created by Vlad Puriy on 4/10/23.
//

import SwiftUI


struct TeacherConnectCodeView: View {
    //Add this binding state for transitions from view to view
    @Binding var showNextView: DisplayState
    
    @State private var generatedCode: String = ""
    
    //array used to generate a random character string
    @State private var charList = ["1","2","3","4","5","6","7","8","9","0",
                    "a","b","c","d","e","f","g","h","i","j",
                    "k","l","m","n","o","p","q","r","s","t",
                    "u","v","w","x","y","z"]
    
    var body: some View {
        VStack{
            //create into a button
            Button(action: {
                withAnimation {
                    //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                    showNextView = .mainTeacher}
            }){
                //button defining text enclosed by brackets
                Text("MAIN / CONNECT CODE")
                    .fontWeight(btnStyle.getFont())
                    .foregroundColor(btnStyle.getPathFontColor())
                    .frame(width: btnStyle.getWidth(),
                           height: btnStyle.getHeight(),
                           alignment: btnStyle.getAlignment())
            }
            .padding()
            .background(btnStyle.getPathColor())
            .cornerRadius(btnStyle.getPathRadius())
            .padding(.top)
            Spacer()
    
            
            Text("Connect Code")
                .font(.title)
                .padding(.top, 25)
            
            TextField(
                "Press the button to generate a code",
                text: $generatedCode
            )
            .multilineTextAlignment(.center)
            .textFieldStyle(.roundedBorder)
            .disabled(true)
            .padding(25)
            
            
            //generates a random string of 6 characters using characters from the charList array
            Button(action: {
                generatedCode = ""
                for _ in 0..<6{
                    let randomNum = Int.random(in: 0..<36)
                    generatedCode += charList[randomNum]
                }
            }) {
                Text("Generate New Code")
                    .padding()
                    .fontWeight(.bold)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(100)
            }
            .padding(.bottom, 400)
        }
    }
}
struct TeacherConnectCodeView_Previews: PreviewProvider {
    @State static private var showNextView: DisplayState = .connectCode
    
    static var previews: some View {
        TeacherConnectCodeView(showNextView: $showNextView)
    }
    
}
