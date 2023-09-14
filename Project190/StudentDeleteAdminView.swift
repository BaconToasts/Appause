//
//  StudentDeleteAdminView.swift
//  Project190
//
//  Created by Luis Campos on 4/19/23.
//

import SwiftUI
struct StudentDeleteAdminView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var firstButton = "MAIN / CLASSES / REMOVE CLASS"
    @State var secondButton = "YES"
    @State var thirdButton = "NO"
    @State var mainButtonColor = Color.black
    
    var adminName = "Admin"
    
    var body: some View {
        VStack{
            Button(firstButton, action: {dismiss()})
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(5)
                .padding(.top, -30)
                .padding(.bottom, 40)
            Text("Are you sure that you want to request that " + adminName + " removes your registration?").fontWeight(.bold).multilineTextAlignment(.center).frame(width:300, height:150, alignment:.center)
                .padding()
            HStack{
                Button(action:{ dismiss()}){
                    Text(secondButton).fontWeight(.bold).foregroundColor(.white).frame(width:50)
                }
                .padding()
                .background(mainButtonColor)
                .cornerRadius(6)
                .padding(.trailing, 100)
                .padding(.bottom, 250)
                Button(action:{ dismiss()}){
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
    //@State static private var showNextView: DisplayState = .studentDeleteAdmin
    static var previews: some View{
        StudentDeleteAdminView()
    }
}
