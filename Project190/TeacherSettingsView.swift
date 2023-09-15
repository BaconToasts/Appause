//
//  TeacherSettingsView.swift
//  Project190
//
//  Created by Luis Campos on 4/18/23.
//

import SwiftUI
struct TeacherSettingsView: View{
    @Binding var showNextView: DisplayState
    
    @State var firstButton = "MAIN / SETTINGS"
    @State var secondButton = "Change Password"
    @State var thirdButton = "Enable FaceID"
    @State var fourthButton = "Disable Bluetooth"
    @State var borderColor = Color.black
    @State var mainButtonColor = Color.black
    @State var backgroundColor = Color.gray.opacity(0.25)
    
    var body: some View{
        VStack{
            Button(action:{withAnimation{showNextView = .mainTeacher}}){
                Text(firstButton)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 20, alignment:.center)
            }
            .padding()
            .background(mainButtonColor)
            .cornerRadius(100)
            .padding(.top)
            Spacer()
            
            Button(action:{}){
                Text(secondButton)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(width: 300, height: 20, alignment:.center)
            }
            .padding()
            .background(backgroundColor)
            .border(mainButtonColor, width: 5)
            .cornerRadius(6)
            .padding(.bottom, 10)
            
            
            Button(action:{}){
                Text(thirdButton)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(width: 300, height: 20, alignment:.center)
            }
            .padding()
            .background(backgroundColor)
            .border(mainButtonColor, width: 5)
            .cornerRadius(6)
            .padding(.bottom, 10)
            
            
            Button(action:{}){
                Text(fourthButton).fontWeight(.bold).foregroundColor(.black).frame(width: 300, height: 20, alignment:.center)
            }
            .padding()
            .background(backgroundColor)
            .border(mainButtonColor, width: 5)
            .cornerRadius(6)
            .padding(.bottom, 300)
        }
    }
}
struct TeacherSettingsView_Previews: PreviewProvider{
    @State static private var showNextView: DisplayState = .teacherSettings
    static var previews: some View{
        TeacherSettingsView(showNextView: $showNextView)
    }
}
