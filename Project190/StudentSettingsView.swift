//
//  StudentSettingsView.swift
//  Project190
//
//  Created by Luis Campos on 4/17/23.
//

import SwiftUI

struct StudentSettingsView: View{
    @Binding var showNextView: DisplayState
    
    @State var firstButton = "MAIN / SETTINGS"
    @State var secondButton = "Change Password"
    @State var thirdButton = "Enable FaceID"
    @State var fourthButton = "Disable Bluetooth"
    @State var fifthButton = "Dark Mode"
    
    @State private var colorScheme =  btnStyle.getStudentScheme()
    
    var body: some View{
        VStack{
            Button(action:{withAnimation{showNextView = .mainStudent}}){
                Text(firstButton)
                    .fontWeight(btnStyle.getFont())
                    .foregroundColor(btnStyle.getPathFontColor())
                    .frame(width: btnStyle.getWidth(),
                           height: btnStyle.getHeight(),
                           alignment: btnStyle.getAlignment())
            }
            .padding()
            .background(btnStyle.getPathColor())
            .cornerRadius(btnStyle.getPathRadius())
            .padding(.top)
            Spacer()
            
            Button(action:{withAnimation{showNextView = .emailCode}}){
                Text(secondButton)
                    .fontWeight(btnStyle.getFont())
                    .foregroundColor(btnStyle.getBtnFontColor())
                    .frame(width: btnStyle.getWidth(),
                           height: btnStyle.getHeight(),
                           alignment: btnStyle.getAlignment())
            }
            .padding()
            .background(btnStyle.getBtnColor())
            .border(btnStyle.getBorderColor(), width: btnStyle.getBorderWidth())
            .cornerRadius(btnStyle.getBtnRadius())
            .padding(.bottom, 10)
            
            Button(action:{}){
                Text(thirdButton).fontWeight(.bold).fontWeight(btnStyle.getFont())
                    .foregroundColor(btnStyle.getBtnFontColor())
                    .frame(width: btnStyle.getWidth(),
                           height: btnStyle.getHeight(),
                           alignment: btnStyle.getAlignment())
            }
            .padding()
            .background(btnStyle.getBtnColor())
            .border(btnStyle.getBorderColor(), width: btnStyle.getBorderWidth())
            .cornerRadius(btnStyle.getBtnRadius())
            .padding(.bottom, 10)

            Button(action:{}){
                Text(fourthButton)
                    .fontWeight(btnStyle.getFont())
                    .foregroundColor(btnStyle.getBtnFontColor())
                    .frame(width: btnStyle.getWidth(),
                           height: btnStyle.getHeight(),
                           alignment: btnStyle.getAlignment())
            }
            .padding()
            .background(btnStyle.getBtnColor())
            .border(btnStyle.getBorderColor(), width: btnStyle.getBorderWidth())
            .cornerRadius(btnStyle.getBtnRadius())
            .padding(.bottom, 10)
            
            Button(action:{
                btnStyle.setStudentScheme()
                colorScheme = btnStyle.getStudentScheme()
                if colorScheme == 0{
                    fifthButton = "Dark Mode"
                }
                else
                {
                    fifthButton = "Light Mode"
                }
            }){
                Text(fifthButton)
                    .fontWeight(btnStyle.getFont())
                    .foregroundColor(btnStyle.getBtnFontColor())
                    .frame(width: btnStyle.getWidth(),
                           height: btnStyle.getHeight(),
                           alignment: btnStyle.getAlignment())
            }
            .padding()
            .background(btnStyle.getBtnColor())
            .border(btnStyle.getBorderColor(), width: btnStyle.getBorderWidth())
            .cornerRadius(btnStyle.getBtnRadius())
            .padding(.bottom, 300)
        }
        .preferredColorScheme(colorScheme == 0 ? .light : .dark)
    }
}

struct StudentSettingsView_Previews: PreviewProvider{
    @State static private var showNextView: DisplayState = .studentSettings
    static var previews: some View{
        StudentSettingsView(showNextView: $showNextView)
    }
}
