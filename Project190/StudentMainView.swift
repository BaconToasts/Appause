//
//  ContentView.swift
//  studentMainScreen
//
//  Created by Luis Campos on 4/6/23.
//  Modified by Nav Bernal on 4/20/23.
//

import SwiftUI

struct StudentMainView: View {
    //Add this binding state for transitions from view to view
    @Binding var showNextView: DisplayState
    
    @State var mainButtonColor = Color.black
    @State var secondButtonName = "Classes"
    @State var thirdButtonName = "Settings"
    @State var fourthButtonName = "Logout"
    
    var body: some View {
        VStack {
            // Button that displays current path
            Button(action:{}){
                Text("MAIN").foregroundColor(.white).fontWeight(.bold).frame(width:300, height: 20, alignment: .center)
            }
            .padding()
            .background(mainButtonColor)
            .cornerRadius(100)
            //.padding(.bottom, 10)
            Spacer()
            // When clicked, will allow students to view and manage all of their classes
            Button(action: {
                withAnimation {
            //make button show nextView .whateverViewYouWantToShow defined in ContentView Enum
                    showNextView = .studentConnectCode}
            }){
                Text(secondButtonName)
                    .foregroundColor(.black)
                    .frame(width: 335, height: 30, alignment: .center)
                    .fontWeight(.bold)
            }
            .padding()
            .border(Color.black, width: 5)
            .cornerRadius(6)
            .padding(.bottom, 10)
            // When clicked, will take the student to the settings view
            Button(action: {withAnimation {showNextView = .studentSettings}}){
                Text(thirdButtonName)
                    .foregroundColor(.black)
                    .frame(width: 300, height: 20, alignment: .center)
                    .fontWeight(.bold)
                Image(systemName: "gear")
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
            .padding()
            .border(Color.black, width: 5)
            .cornerRadius(6)
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
