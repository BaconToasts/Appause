//
//  StudentRequestView.swift
//
//
//  Created by user on 4/19/23.
//
//

import SwiftUI

struct TeacherAppView: View {
    @State var request: RequestData
    @State var studentName: String
    @State var parentNavText: String
   
    var body: some View {
        ZStack {
            Image(systemName:"applelogo")
                .frame(maxWidth:.infinity, alignment:.leading)
            
            NavigationLink(destination: TeacherAppDescription(appData: $request, parentNavText: parentNavText, studentName: studentName)
                .navigationBarHidden(true)) {
                AppRequestView(request: request)
            }
        }
    }
}

//ApproveStatus, RequestData, AppRequestView defined in RequestData

struct TeacherUserRequestView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var stackingPermitted : String?
    
    @State private var searchAppName: String = ""
    var userName = "User"
    
    @State var appList:[RequestData] = [
        RequestData(appName: "Unprocessed Request", approved: ApproveStatus.unprocessed),
        RequestData(appName: "Approved App", approved: ApproveStatus.approved),
        RequestData(appName: "Temporarily Approved App", approved: ApproveStatus.approvedTemporary),
        RequestData(appName: "Denied App", approved: ApproveStatus.denied)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {dismiss()}) {
                        Text("MAIN / MANAGE USER / " + String(userName).uppercased())
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
                
                Text("App Requests")
                    .padding(.top, 50)
                    .padding(.bottom, 5)
                TextField(
                    "Search",
                    text: $searchAppName
                )
                .multilineTextAlignment(.center)
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth:1))
                .frame(maxWidth: UIScreen.main.bounds.size.width*0.75)
                
                List {
                    ForEach(appList) { request in
                        if(searchAppName.isEmpty ||
                           request.appName.contains(searchAppName)) {
                            TeacherAppView(request: request, studentName: userName, parentNavText: "MANAGE USER / ")
                        }
                    }
                }
                .overlay(RoundedRectangle(cornerRadius:10, style:.circular)
                    .stroke(lineWidth:3))
                .frame(maxWidth: UIScreen.main.bounds.size.width*0.85,
                       maxHeight: UIScreen.main.bounds.size.height*0.7)
                
                NavigationLink(destination: TeacherDeleteStudentView(stackingPermitted: self.$stackingPermitted, studentName: userName)
                    .navigationBarHidden(true)) {
                        Text("Delete User")
                        .padding()
                        .fontWeight(btnStyle.getFont())
                        .background(btnStyle.getPathColor())
                        .foregroundColor(btnStyle.getPathFontColor())
                        .cornerRadius(25)
                    
                }
                    .isDetailLink(false)
                    .padding(.top, 10)
            }
        }
        .preferredColorScheme(btnStyle.getTeacherScheme() == 0 ? .light : .dark)
    }
}

struct TeacherAppRequestView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherUserRequestView(stackingPermitted: .constant(nil))
    }
}
