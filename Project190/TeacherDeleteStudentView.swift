//
//  TeacherDeleteStudentView.swift
//  Project190
//
//  Created by Luis Campos on 4/19/23.
//

import SwiftUI
struct TeacherDeleteStudentView: View{
    @Binding var showNextView: DisplayState
    
    @State var firstButton = "Main / Manage Users / Delete Student"
    @State var secondButton = "Yes"
    @State var thirdButton = "No"
    @State var borderColor = Color.black
    @State var mainButtonColor = Color.black
    
    var body: some View{
        VStack{
            Button(action:{withAnimation{showNextView = .teacherAppRequest}}){
                Text(firstButton).fontWeight(.bold).foregroundColor(.white).frame(width: 300, height: 20, alignment:.center)
            }
            .padding()
            .background(mainButtonColor)
            .cornerRadius(100)
            .padding(.bottom, 180)
            Text("Are you sure that you want to permanently delete this student from your list of registered users?").fontWeight(.bold).multilineTextAlignment(.center).frame(width:300, height:150, alignment:.center)
                .padding()
            HStack{
                Button(action:{}){
                    Text(secondButton).fontWeight(.bold).foregroundColor(.white).frame(width:50)
                }
                .padding()
                .background(mainButtonColor)
                .cornerRadius(6)
                .padding(.trailing, 100)
                .padding(.bottom, 250)
                Button(action:{withAnimation{showNextView = .teacherManageUsers}}){
                    Text(thirdButton).fontWeight(.bold).foregroundColor(mainButtonColor).frame(width:50)
                }
                .padding()
                .border(borderColor, width: 5)
                .cornerRadius(6)
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
