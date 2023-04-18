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
    @State private var otherbtnColor: Color = Color.gray.opacity(0.2)
    @State private var btnAlignment: Alignment = .center
    @State private var cornerRadius: CGFloat = 5
    @State private var frameWidth: CGFloat = 300
    @State private var frameHeight: CGFloat = 50
    @State private var fontStyle: Font = .title2
    
    var body: some View {
        VStack{
            
            // create Main button
            Button(action:{})
            {
                Text("Main")
                    .font(fontStyle)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
            }
            .background(mainbtnColor)
            .cornerRadius(cornerRadius)
            .padding()
            // create Requests button
            Button(action:{})
            {
                (Text(Image(systemName: "bell")) +
                 Text("   Requests   ") +
                 Text(Image(systemName: "hand.raised")))
                .font(fontStyle)
                .foregroundColor(.black)
                .frame(width: frameWidth,
                       height: frameHeight,
                       alignment: btnAlignment)
            }
            .background(otherbtnColor)
            .cornerRadius(cornerRadius)
            
            // create Whitelist button
            Button(action:{})
            {
                (Text("   Whitelist  ") + Text(Image(systemName: "bookmark.slash")))
                    .font(fontStyle)
                    .foregroundColor(.black)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
            }
            .background(otherbtnColor)
            .cornerRadius(cornerRadius)
            
            // create Manage Users button
            Button(action:{})
            {
                (Text(" Manage Users ") + Text(Image(systemName: "person")) + Text(Image(systemName: "person")))
                    .font(fontStyle)
                    .foregroundColor(.black)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
            }
            .background(otherbtnColor)
            .cornerRadius(cornerRadius)
            
            // create Connect Code button
            Button(action:{
                withAnimation {
                    //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                showNextView = .connectCode}
                
            })
            {
                Text("Connect Code")
                    .font(fontStyle)
                    .foregroundColor(.black)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
            }
            .background(otherbtnColor)
            .cornerRadius(cornerRadius)
            
            // create Settings button
            Button(action:{withAnimation{showNextView = .teacherSettings}})
            {
                (Text("     Settings  ") + Text(Image(systemName: "gear")))
                    .font(fontStyle)
                    .foregroundColor(.black)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
            }
            .background(otherbtnColor)
            .cornerRadius(cornerRadius)
            
            
            // create Master Control button
            Button(action:{
                withAnimation {
                //show nextView .whateverViewYouWantToShow defined in ContentView Enum
            showNextView = .teacherMasterControl}
            })
            {
                (Text(" Master Control  ") + Text(Image(systemName: "lock")))
                    .font(fontStyle)
                    .foregroundColor(.black)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
                
                
            }
            .background(otherbtnColor)
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
