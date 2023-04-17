// Project190
// MainTeacherView.swift
//  Created by Eduardo Mariano on 4/6/23.
//
//  Purpose: Acts as GUI for the user in order to
//           navigate to specfic features of the app.
//           (currently non-functional)

import SwiftUI

struct TeacherMainView: View {
    //Add this binding state for transitions from view to view
    @Binding var showNextView: DisplayState
    @State private var mainbtnColor: Color = Color.black
    @State private var borderColor: Color = Color.black
    @State private var btnAlignment: Alignment = .center
    @State private var fontWeight:  Font.Weight = .bold
    @State private var cornerRadius: CGFloat = 6
    @State private var frameWidth: CGFloat = 300
    @State private var frameHeight: CGFloat = 20
    
    
    var body: some View {
        VStack{
            
            // create Main button
            Button(action:{})
            {
                Text("MAIN")
                    .fontWeight(fontWeight)
                    .background(.black)
                    .foregroundColor(.white)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
            }
            .padding()
            .background(mainbtnColor)
            .border(borderColor, width: 5)
            .cornerRadius(100)
            .padding(.bottom, 30)
            
            // create Requests button
            Button(action:{})
            {
                (Text(Image(systemName: "bell")) +
                 Text("   Requests   ") +
                 Text(Image(systemName: "hand.raised")))
                .fontWeight(fontWeight)
                .foregroundColor(.black)
                .frame(width: frameWidth,
                       height: frameHeight,
                       alignment: btnAlignment)
            }
            .padding()
            .border(borderColor, width: 5)
            .cornerRadius(cornerRadius)
            .padding(.bottom, 10)
            
            // create Whitelist button
            Button(action:{})
            {
                (Text("   Whitelist  ") + Text(Image(systemName: "bookmark.slash")))
                    .fontWeight(fontWeight)
                    .foregroundColor(.black)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
            }
            .padding()
            .border(borderColor, width: 5)
            .cornerRadius(cornerRadius)
            .padding(.bottom, 10)
            
            // create Manage Users button
            Button(action:{})
            {
                (Text("  Manage Users ") + Text(Image(systemName: "person")) + Text(Image(systemName: "person")))
                    .fontWeight(fontWeight)
                    .foregroundColor(.black)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
            }
            .padding()
            .border(borderColor, width: 5)
            .cornerRadius(cornerRadius)
            .padding(.bottom, 10)
            
            // create Connect Code button
            Button(action:{
                withAnimation {
                    //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                showNextView = .connectCode}
                
            })
            {
                Text("Connect Code")
                    .fontWeight(fontWeight)
                    .foregroundColor(.black)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
            }
            .padding()
            .border(borderColor, width: 5)
            .cornerRadius(cornerRadius)
            .padding(.bottom, 10)
            
            // create Settings button
            Button(action:{})
            {
                (Text("     Settings  ") + Text(Image(systemName: "gear")))
                    .fontWeight(fontWeight)
                    .foregroundColor(.black)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
            }
            .padding()
            .border(borderColor, width: 5)
            .cornerRadius(cornerRadius)
            .padding(.bottom, 10)
                       
            
            
            // create Master Control button
            Button(action:{
                withAnimation {
                //show nextView .whateverViewYouWantToShow defined in ContentView Enum
            showNextView = .teacherMasterControl}
            })
            {
                (Text(" Master Control  ") + Text(Image(systemName: "lock")))
                    .fontWeight(fontWeight)
                    .foregroundColor(.black)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
                
                
            }
            .padding()
            .border(borderColor, width: 5)
            .cornerRadius(cornerRadius)
            .padding(.bottom, 200)
            
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

struct MainTeacherView_Previews: PreviewProvider {
        @State static private var showNextView: DisplayState = .mainTeacher

        static var previews: some View {
            TeacherMainView(showNextView: $showNextView)
        }

}
