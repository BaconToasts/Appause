//
//  TeacherManageUsers.swift
//  Project190
//
//  Created by user123 on 4/20/23.
//

import SwiftUI

struct TeacherManageUsers: View
{
    //Add this binding state for transitions from view to view
    @Binding var showNextView: DisplayState
    @State var studentName = ""
    @State var studentList = [
        "John Doe",
        "John Jackson",
        "Danny Devito",
        "Taylor Newall",
        "Xavier Desmond",
        "Ronald McDonald"]
    
    var body: some View
    {
        NavigationView{
            VStack
            {
                Button(action: {
                    withAnimation {
                        //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                        showNextView = .mainTeacher}
                }){
                    Text("MAIN / MANAGE USERS")
                        .fontWeight(btnStyle.getFont())
                        .foregroundColor(.white)
                        .frame(width: btnStyle.getWidth(),
                               height: btnStyle.getHeight(),
                               alignment: btnStyle.getAlignment())
                       
                }
                .padding()
                .background(btnStyle.getPathColor())
                .cornerRadius(btnStyle.getPathRadius())
                .padding(.top)
                Spacer()
                
                TextField("Search for Registered Users",text: $studentName)
                    .multilineTextAlignment(.center)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth:1))
                    .frame(maxWidth:UIScreen.main.bounds.size.width*0.75)
                    .padding(.bottom, 25)
                    .padding(.top, 30)
                
                List {
                    ForEach(studentList, id:\.self) { student in
                        if(studentName.isEmpty || student.contains(studentName))
                        {
                            NavigationLink(destination:TeacherAppRequestView(userName: student)
                                .navigationBarHidden(true)){
                                Text(student)
                                    .font(.callout)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                .overlay(RoundedRectangle(cornerRadius:10, style:.circular)
                    .stroke(lineWidth:5))
                .frame(maxWidth: UIScreen.main.bounds.size.width*0.80,
                       maxHeight: UIScreen.main.bounds.size.height*0.75)
                .padding(.bottom, 300)
                .cornerRadius(5)
                
            }}
    }
    
    struct TeacherManageUsers_Previews: PreviewProvider {
        @State static private var showNextView: DisplayState = .teacherManageUsers
        
        static var previews: some View {
            TeacherManageUsers(showNextView: $showNextView)
        }
    }
}
