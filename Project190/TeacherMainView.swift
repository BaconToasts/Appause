// Project190
// MainTeacherView.swift
//  Created by Eduardo Mariano on 4/6/23.
//
//  Purpose: Acts as GUI for the user in order to
//           navigate to specfic features of the app.
//

import SwiftUI

struct TeacherMainView: View {
    //Add this binding state for transitions from view to view
    @Binding var showNextView: DisplayState
    @State private var mainbtnColor: Color = Color.black
    @State private var borderColor: Color = Color.black
    @State private var btnColor: Color = Color.gray.opacity(0.25)
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
            Button(action:{
                withAnimation {
            //make button show nextView .whateverViewYouWantToShow defined in ContentView Enum
                    showNextView = .teacherAppRequest}
            })
            {
              Text("Requests")
                    .padding(.leading, 25)
                    .fontWeight(fontWeight)
                    .foregroundColor(.black)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
                
                Image(systemName: "hand.raised")
                    .fontWeight(fontWeight)
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
            .padding()
            .background(btnColor)
            .border(borderColor, width: 5)
            .cornerRadius(cornerRadius)
            .padding(.bottom, 10)
            
            // create Whitelist button
            Button(action:{})
            {
                Text("Whitelist")
                    .padding(.leading, 20)
                    .fontWeight(fontWeight)
                    .foregroundColor(.black)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
                
                Image(systemName: "bookmark.slash")
                    .fontWeight(fontWeight)
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
            .padding()
            .background(btnColor)
            .border(borderColor, width: 5)
            .cornerRadius(cornerRadius)
            .padding(.bottom, 10)
            
            // create Manage Users button
            Button(action:{
                withAnimation {
            //make button show nextView .whateverViewYouWantToShow defined in ContentView Enum
                    showNextView = .teacherManageUsers}
            })
            {
                Text("Manage Users")
                    .padding(.leading, 25)
                    .fontWeight(fontWeight)
                    .foregroundColor(.black)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
                
                Image(systemName: "person")
                    .fontWeight(fontWeight)
                    .imageScale(.large)
                    .foregroundColor(.black)
            
            }
            .padding()
            .background(btnColor)
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
                    .frame(width: frameWidth + 35,
                           height: frameHeight + 5,
                           alignment: btnAlignment)
            }
            .padding()
            .background(btnColor)
            .border(borderColor, width: 5)
            .cornerRadius(cornerRadius)
            .padding(.bottom, 10)
            
            // create Settings button
            Button(action:{withAnimation{showNextView = .teacherSettings}})
            {
                Text("Settings")
                    .padding(.leading, 25)
                    .fontWeight(fontWeight)
                    .foregroundColor(.black)
                    .frame(width: frameWidth,
                           height: frameHeight,
                           alignment: btnAlignment)
                
                Image(systemName: "gear")
                    .fontWeight(fontWeight)
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
            .padding()
            .background(btnColor)
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
                Text("Master Control")
                    .padding(.leading, 25)
                    .fontWeight(fontWeight)
                    .foregroundColor(.black)
                    .frame(width: frameWidth + 5,
                           height: frameHeight,
                           alignment: btnAlignment)
                
                Image(systemName: "lock")
                    .fontWeight(fontWeight)
                    .imageScale(.large)
                    .foregroundColor(.black)
                
            }
            .padding()
            .background(btnColor)
            .border(borderColor, width: 5)
            .cornerRadius(cornerRadius)
            .padding(.bottom, 100)
            
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
