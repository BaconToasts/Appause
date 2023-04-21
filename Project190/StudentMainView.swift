//
//  ContentView.swift
//  studentMainScreen
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
    @State var thirdButtonName = "Settings"
    @State var fourthButtonName = "Logout"
    
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
            Button(action:{}){
                Text(secondButtonName)
                    .foregroundColor(.black)
                    .frame(width: 335, height: 30, alignment: .center)
                    .fontWeight(.bold)
            }
            .padding()
            .background(btnColor)
            .border(Color.black, width: 5)
            .cornerRadius(cornerRadius)
            .padding(.bottom, 10)
            // When pressed, will take the student to the settings view
            Button(action: {withAnimation {showNextView = .studentSettings}}){
                Text(thirdButtonName)
                    .padding(.leading, 40)
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
            .padding(.bottom, 325)
            // When pressed, will take the student back to the main login page
            Button(action: {
                withAnimation {
                    //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                    showNextView = .logout}
            }){
                Text(fourthButtonName)
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
