//
//  StudentMainView.swift
//
//  Created by Luis Campos on 4/6/23.
//  Modified by Nav Bernal and Alec Lobato on 4/20/23.
//

import SwiftUI

struct StudentMainView: View {
    //Add this binding state for transitions from view to view
    @Binding var showNextView: DisplayState
    
    @State var mainButtonColor = Color.black
    @State private var btnColor: Color = Color.gray.opacity(0.25)
    @State private var cornerRadius: CGFloat = 6
    @State private var frameWidth: CGFloat = 300
    @State private var frameHeight: CGFloat = 20
    
    @State var secondButtonName = "Classes"
    @State var thirdButtonName = "Connect Code"
    @State var fourthButtonName = "Settings"
    
    var body: some View {
        VStack {
            Button(action:{}){
                Text("MAIN").foregroundColor(.white).fontWeight(.bold).frame(width:frameWidth, height: frameHeight, alignment: .center)
            }
            .padding()
            .background(mainButtonColor)
            .border(Color.black, width: 5)
            .cornerRadius(100)
            Spacer()
            // When pressed, will allow students to view and manage all of their classes
            Button(action:{withAnimation
                {showNextView = .studentChooseAdmin}
            }){
                Text(secondButtonName)
                    .padding(.leading, 25)
                    .foregroundColor(.black)
                    .frame(width: frameWidth, height: frameHeight, alignment: .center)
                    .fontWeight(.bold)
                Image(systemName: "hand.raised")
                    .fontWeight(.bold)
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
            .padding()
            .background(btnColor)
            .border(Color.black, width: 5)
            .cornerRadius(6)
            .padding(.bottom, 10)
                        
            Button(action: {
                withAnimation {
            //make button show nextView .whateverViewYouWantToShow defined in ContentView Enum
                    showNextView = .studentConnectCode}
            }){
                Text(thirdButtonName)
                    .padding(.leading, 25)
                    .foregroundColor(.black)
                    .frame(width: 335, height: frameHeight, alignment: .center)
                    .fontWeight(.bold)
            }
            .padding()
            .background(btnColor)
            .border(Color.black, width: 5)
            .cornerRadius(cornerRadius)
            .padding(.bottom, 10)
            Button(action: {withAnimation {showNextView = .studentSettings}}){
                Text(fourthButtonName)
                    .padding(.leading, 25)
                    .foregroundColor(.black)
                    .frame(width: frameWidth, height: frameHeight, alignment: .center)
                    .fontWeight(.bold)
                Image(systemName: "gear")
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
            .padding()
            .background(btnColor)
            .border(Color.black, width: 5)
            .cornerRadius(cornerRadius)
            .padding(.bottom, 335)
            // When pressed, will take the student back to the main login page
            Button(action: {
                withAnimation {
                    //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                    showNextView = .logout}
            }){
                Text("Logout")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
            }
            .padding()
            .background(Color.red)
            .cornerRadius(200)
        }
        .padding()
    }
}

struct StudentMainView_Previews: PreviewProvider {
    @State static private var showNextView: DisplayState = .mainStudent

    static var previews: some View {
        StudentMainView(showNextView: $showNextView)
    }
}
