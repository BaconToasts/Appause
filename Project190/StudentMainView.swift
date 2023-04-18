//
//  ContentView.swift
//  studentMainScreen
//
//  Created by user1 on 4/6/23.
//

import SwiftUI

struct StudentMainView: View {
    //Add this binding state for transitions from view to view
    @Binding var showNextView: DisplayState
    
    @State var mainButtonColor = Color.black
    @State var secondButtonName = "REQUESTS"
    @State var thirdButtonName = "CONNECT CODE"
    @State var fourthButtonName = "SETTINGS"
    @State var fifthButtonName = "MANAGE ADMIN"
    @State var sixthButtonName = "Logout"
    
    var body: some View {
        VStack {
            Button(action:{}){
                Text("MAIN").foregroundColor(.white).fontWeight(.bold).frame(width:300, height: 20, alignment: .center)
            }
            .padding()
            .background(mainButtonColor)
            .cornerRadius(100)
            .padding(.bottom, 50)
            Button(action:{}){
                Text(secondButtonName)
                    .foregroundColor(.black)
                    .frame(width: 300, height: 20, alignment: .center)
                    .fontWeight(.bold)
                Image(systemName: "hand.raised")
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
            .padding()
            .border(Color.black, width: 5)
            .cornerRadius(6)
            .padding(.bottom, 10)
                        
            Button(action: {
                withAnimation {
            //make button show nextView .whateverViewYouWantToShow defined in ContentView Enum
                    showNextView = .studentConnectCode}
            }){
                Text(thirdButtonName)
                    .foregroundColor(.black)
                    .frame(width: 335, height: 30, alignment: .center)
                    .fontWeight(.bold)
            }
            .padding()
            .border(Color.black, width: 5)
            .cornerRadius(6)
            .padding(.bottom, 10)
            Button(action: {withAnimation {showNextView = .studentSettings}}){19
                Text(fourthButtonName)
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
            .padding(.bottom, 10)
                        
            Button(action: {}){
                Text(fifthButtonName)
                    .foregroundColor(.black)
                    .frame(width: 335, height: 30, alignment: .center)
                    .fontWeight(.bold)
            }
            .padding()
            .border(Color.black, width: 5)
            .cornerRadius(6)
            .padding(.bottom, 265)
            Button(action: {
                withAnimation {
                    //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                    showNextView = .logout}
            }){
                Text(sixthButtonName)
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
