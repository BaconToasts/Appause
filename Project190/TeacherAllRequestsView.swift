//
//  TeacherAllRequestsView.swift
//  Project190
//
//  Created by UserSSD on 10/13/23.
//

import SwiftUI

struct TeacherAllRequestsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var searchAppName: String = ""
    var userName = "User"
    
    @State var appList:[RequestData] = [
        RequestData(appName: "App 1", approved: ApproveStatus.unprocessed),
        RequestData(appName: "App 2", approved: ApproveStatus.approved),
        RequestData(appName: "App 3", approved: ApproveStatus.denied)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {dismiss()}) {
                        Text("MAIN / REQUESTS")
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
                            TeacherAppView(request: request, studentName: userName)
                        }
                    }
                }
                .overlay(RoundedRectangle(cornerRadius:10, style:.circular)
                    .stroke(lineWidth:3))
                .frame(maxWidth: UIScreen.main.bounds.size.width*0.85,
                       maxHeight: UIScreen.main.bounds.size.height*0.7)
            }
        }
        .preferredColorScheme(btnStyle.getTeacherScheme() == 0 ? .light : .dark)
    }
}

struct TeacherAllRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherAllRequestsView()
    }
}
