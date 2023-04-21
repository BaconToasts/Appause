//
//  StudentDeleteAdminView.swift
//  Project190
//
//  Created by Luis Campos on 4/19/23.
//

import SwiftUI
struct StudentDeleteAdminView: View{
    @Binding var showNextView: DisplayState
    
    @State var firstButton = "Main / Classes / Remove Class"
    @State var secondButton = "Yes"
    @State var thirdButton = "No"
    @State var mainButtonColor = Color.black
    
    var body: some View{
        VStack{
            Button(action:{}){
                Text(firstButton).fontWeight(.bold).foregroundColor(.white).frame(width: 300, height: 20, alignment: .center)
            }
            .padding()
            .background(mainButtonColor)
            .cornerRadius(100)
            .padding(.bottom, 180)
            Text("Are you sure that you want to request that this admin removes your registration?").fontWeight(.bold).multilineTextAlignment(.center).frame(width:300, height:150, alignment:.center)
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
                Button(action:{}){
                    Text(thirdButton).fontWeight(.bold).foregroundColor(mainButtonColor).frame(width:50)
                }
                .padding()
                .border(mainButtonColor, width: 5)
                .cornerRadius(6)
                .padding(.bottom, 250)
            }
        }
    }
}
struct StudentDeleteAdminView_Previews: PreviewProvider{
    @State static private var showNextView: DisplayState = .studentDeleteAdmin
    static var previews: some View{
        StudentDeleteAdminView(showNextView: $showNextView)
    }
}
