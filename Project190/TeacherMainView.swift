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
        
    var body: some View {
        VStack{
            // create Main button
            Button(action:{})
            {
                Text("MAIN")
                    .fontWeight(btnStyle.getFont())
                    .foregroundColor(btnStyle.getPathFontColor())
                    .frame(width: btnStyle.getWidth(),
                           height: btnStyle.getHeight(),
                           alignment: btnStyle.getAlignment())
            }
            .padding()
            .background(btnStyle.getPathColor())
            .cornerRadius(btnStyle.getPathRadius())
            Spacer()
            
            // create Requests button
            Button(action:{
                withAnimation {
            //make button show nextView .whateverViewYouWantToShow defined in ContentView Enum
                    showNextView = .teacherAppRequest}
            })
            {
              Text("Requests")
                    .padding(.leading, 25)
                    .fontWeight(btnStyle.getFont())
                    .foregroundColor(btnStyle.getBtnFontColor())
                    .frame(width: btnStyle.getWidth(),
                           height: btnStyle.getHeight(),
                           alignment: btnStyle.getAlignment())
                
                Image(systemName: "hand.raised")
                    .fontWeight(btnStyle.getFont())
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
            .padding()
            .background(btnStyle.getBtnColor())
            .border(btnStyle.getBorderColor(), width: btnStyle.getBtnRadius())
            .cornerRadius(btnStyle.getBtnRadius())
            .padding(.bottom, 10)
            
            // create Whitelist button
            Button(action:{})
            {
                Text("Whitelist")
                    .padding(.leading, 20)
                    .fontWeight(btnStyle.getFont())
                    .foregroundColor(btnStyle.getBtnFontColor())
                    .frame(width: btnStyle.getWidth(),
                           height: btnStyle.getHeight(),
                           alignment: btnStyle.getAlignment())
                
                Image(systemName: "bookmark.slash")
                    .fontWeight(btnStyle.getFont())
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
            .padding()
            .background(btnStyle.getBtnColor())
            .border(btnStyle.getBorderColor(), width: btnStyle.getBtnRadius())
            .cornerRadius(btnStyle.getBtnRadius())
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
                    .fontWeight(btnStyle.getFont())
                    .foregroundColor(btnStyle.getBtnFontColor())
                    .frame(width: btnStyle.getWidth(),
                           height: btnStyle.getHeight(),
                           alignment: btnStyle.getAlignment())
                
                Image(systemName: "person")
                    .fontWeight(btnStyle.getFont())
                    .imageScale(.large)
                    .foregroundColor(.black)
            
            }
            .padding()
            .background(btnStyle.getBtnColor())
            .border(btnStyle.getBorderColor(), width: btnStyle.getBtnRadius())
            .cornerRadius(btnStyle.getBtnRadius())
            .padding(.bottom, 10)
            
            // create Connect Code button
            Button(action:{
                withAnimation {
                    //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                showNextView = .connectCode}
                
            })
            {
                Text("Connect Code")
                    .fontWeight(btnStyle.getFont())
                    .foregroundColor(btnStyle.getBtnFontColor())
                    .frame(width: btnStyle.getWidth() + 35,
                           height: btnStyle.getHeight() + 5,
                           alignment: btnStyle.getAlignment())
            }
            .padding()
            .background(btnStyle.getBtnColor())
            .border(btnStyle.getBorderColor(), width: btnStyle.getBtnRadius())
            .cornerRadius(btnStyle.getBtnRadius())
            .padding(.bottom, 10)
            
            // create Settings button
            Button(action:{withAnimation{showNextView = .teacherSettings}})
            {
                Text("Settings")
                    .padding(.leading, 25)
                    .fontWeight(btnStyle.getFont())
                    .foregroundColor(btnStyle.getBtnFontColor())
                    .frame(width: btnStyle.getWidth(),
                           height: btnStyle.getHeight(),
                           alignment: btnStyle.getAlignment())
                
                Image(systemName: "gear")
                    .fontWeight(btnStyle.getFont())
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
            .padding()
            .background(btnStyle.getBtnColor())
            .border(btnStyle.getBorderColor(), width: btnStyle.getBtnRadius())
            .cornerRadius(btnStyle.getBtnRadius())
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
                    .fontWeight(btnStyle.getFont())
                    .foregroundColor(.black)
                    .frame(width: btnStyle.getWidth() + 5,
                           height: btnStyle.getHeight(),
                           alignment: btnStyle.getAlignment())
                
                Image(systemName: "lock")
                    .fontWeight(btnStyle.getFont())
                    .imageScale(.large)
                    .foregroundColor(.black)
                
            }
            .padding()
            .background(btnStyle.getBtnColor())
            .border(btnStyle.getBorderColor(), width: btnStyle.getBtnRadius())
            .cornerRadius(btnStyle.getBtnRadius())
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
