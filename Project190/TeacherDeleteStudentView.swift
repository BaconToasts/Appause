//
//  TeacherDeleteStudentView.swift
//  Project190
//
//  Created by Luis Campos on 4/19/23.
//

import SwiftUI
struct TeacherDeleteStudentView: View{
    @Binding var showNextView: DisplayState
    
    @State var firstButton = "MAIN / MANAGE USERS / DELETE STUDENT"
    @State var secondButton = "Yes"
    @State var thirdButton = "No"
    
    var body: some View{
        VStack{
            Button(action:{withAnimation{showNextView = .teacherAppRequest}}){
                Text(firstButton)
                    .fontWeight(btnStyle.getFont())
                    .foregroundColor(btnStyle.getPathFontColor())
                    .frame(width: btnStyle.getWidth(),
                           height: btnStyle.getHeight() + 23,
                           alignment: btnStyle.getAlignment())
            }
            .padding()
            .background(btnStyle.getPathColor())
            .cornerRadius(btnStyle.getPathRadius())
            .padding(.top)
            Spacer()
            
            Text("Are you sure that you want to permanently delete this student from your list of registered users?").fontWeight(.bold).multilineTextAlignment(.center).frame(width:300, height:150, alignment:.center)
                .padding()
            HStack{
                Button(action:{}){
                    Text(secondButton)
                        .fontWeight(btnStyle.getFont())
                        .foregroundColor(.white)
                        .frame(width:50)
                }
                .padding()
                .background(.black)
                .cornerRadius(btnStyle.getBtnRadius())
                .padding(.trailing, 100)
                .padding(.bottom, 250)
                
                Button(action:{withAnimation{showNextView = .teacherManageUsers}}){
                    Text(thirdButton)
                        .fontWeight(btnStyle.getFont())
                        .foregroundColor(.black)
                        .frame(width:50)
                }
                .padding()
                .border(btnStyle.getBorderColor(), width: btnStyle.getBorderWidth())
                .cornerRadius(btnStyle.getBtnRadius())
                .padding(.bottom, 250)
            }
        }
    }
}
struct TeacherDeleteStudentView_Previews: PreviewProvider{
    @State static private var showNextView: DisplayState = .teacherDeleteStudent
    static var previews: some View{
        TeacherDeleteStudentView(showNextView: $showNextView)
    }
}
