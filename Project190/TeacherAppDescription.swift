//
//  TeacherAppApproval.swift
//  Project190
//
//  Created by UserSSD on 9/24/23.
//

import SwiftUI

struct TeacherAppDescription: View {
    @Environment(\.dismiss) private var dismiss
    @State var appData = RequestData(appName:"App", approved: ApproveStatus.unprocessed)
    @State var parentNavText = "MANAGE USER / "
    @State var studentName = "Student"
    @State var requestReason = "Generic Request Reason"
    @State private var hours = 0
    @State private var minutes = 0
    @State private var showAlert = false
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack{
            Button(action: {dismiss()}) {
                Text(parentNavText + studentName + " / " + appData.appName)
                    .textCase(.uppercase)
            }
            .buttonStyle()
            
            Text(studentName + " is requesting access to " + appData.appName + ".")
                .padding(.top)
            
            ZStack{
                VStack{
                    HStack{
                        Image(systemName:"applelogo") //Should use the icon of the app
                        Text(appData.appName)
                            .fontWeight(.bold)
                    }
                    .padding(.bottom)
                    Text(appData.appDescription)
                }
                .padding()
            }
            .border(Color("BlackWhite"), width:3)
            
            Text(studentName + " provided the following reason for this request: ")
                .multilineTextAlignment(.center)
                .padding(.top)
            
            Text(requestReason)
                .padding()
                .border(Color("BlackWhite"), width:2)
            
            Text("Allow access to this app?")
                .padding(.top)
            
            VStack{
                Button("Approve Permanently", action:{
                    appData.approved = ApproveStatus.approved
                    appData.approvedDuration = .infinity
                    dismiss()
                })
                .buttonStyle()
                .padding(.bottom)
                
                Button("Approve Temporarily", action:{
                    if(hours == 0 && minutes == 0) {
                        showAlert = true
                    }
                    else {
                        showAlert = false
                        appData.approved = ApproveStatus.approved
                        appData.approvedDuration = Float(hours*60 + minutes)
                        dismiss()
                    }
                })
                .buttonStyle()
                .alert("Duration should be longer than 0 minutes.", isPresented:$showAlert) {
                    Button("OK", role:.cancel) {}
                }
                HStack {
                    VStack{
                        Text("Hours")
                            .padding(.bottom, -5)
                        TextField("Hours", value:$hours, format:.number)
                            .multilineTextAlignment(.center)
                            .overlay(RoundedRectangle(cornerRadius:14).stroke(Color("BlackWhite"), lineWidth:2))
                            
                    }
                    .padding(.leading)
                    VStack{
                        Text("Minutes")
                            .padding(.bottom, -5)
                        TextField("Minutes", value:$minutes, format:.number)
                            .multilineTextAlignment(.center)
                            .overlay(RoundedRectangle(cornerRadius:14).stroke(Color("BlackWhite"), lineWidth:2))
                    }
                    .padding(.trailing)
                }
                .padding(.bottom)
                
                Button("Deny", action:{
                    appData.approved = ApproveStatus.denied
                    dismiss()
                })
                .buttonStyle()
                
            }
            
            
            Spacer()
            
        }
        .preferredColorScheme(btnStyle.getTeacherScheme() == 0 ? .light : .dark)
    }
    
}

extension View {
    func buttonStyle() -> some View {
        self
            .fontWeight(btnStyle.getFont())
            .foregroundColor(btnStyle.getPathFontColor())
            .frame(width:btnStyle.getWidth(),
                   height:btnStyle.getHeight(),
                   alignment:btnStyle.getAlignment())
            .padding()
            .background(btnStyle.getPathColor())
            .cornerRadius(btnStyle.getPathRadius())
    }
}

struct TeacherAppApproval_Previews: PreviewProvider {
    static var previews: some View {
        TeacherAppDescription()
    }
}
