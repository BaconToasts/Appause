//
//  TeacherDeleteStudentView.swift
//  Project190
//
//  Created by Luis Campos on 4/19/23.
//

import SwiftUI
struct TeacherDeleteStudentView: View{
    @Environment(\.dismiss) private var dismiss
    @Binding var stackingPermitted : Bool
    
    @State var firstButton = "MAIN / MANAGE USERS / DELETE STUDENT"
    @State var secondButton = "Yes"
    @State var thirdButton = "No"
    
    var body: some View{
        VStack{
            Button(action: {dismiss()}) {
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
                Button(action:{
                    stackingPermitted = false
                    dismiss()}){
                    Text(secondButton)
                        .fontWeight(btnStyle.getFont())
                        .foregroundColor(btnStyle.getPathFontColor())
                        .frame(width:50)
                }
                .padding()
                .background(btnStyle.getBtnFontColor())
                .cornerRadius(btnStyle.getBtnRadius())
                .padding(.trailing, 100)
                .padding(.bottom, 250)
                
                Button(action: {
                    stackingPermitted = true
                    dismiss()}) {
                    Text(thirdButton)
                        .fontWeight(btnStyle.getFont())
                        .foregroundColor(btnStyle.getBtnFontColor())
                        .frame(width:50)
                }
                .padding()
                .border(btnStyle.getBorderColor(), width: btnStyle.getBorderWidth())
                .cornerRadius(btnStyle.getBtnRadius())
                .padding(.bottom, 250)
            }
        }
        .preferredColorScheme(btnStyle.getTeacherScheme() == 0 ? .light : .dark)
    }
}
struct TeacherDeleteStudentView_Previews: PreviewProvider{
    static var previews: some View{
        TeacherDeleteStudentView(stackingPermitted: .constant(false))
    }
}
