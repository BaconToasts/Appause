//
//  StudentRequestView.swift
//
//
//  Created by user on 4/6/23.
//

import SwiftUI

enum ApproveStatus {
    case approved
    case denied
    case unprocessed
}

struct RequestData: Hashable, Identifiable {
    let id = UUID()
    var appName: String
    var approved: ApproveStatus
    
    init(appName:String, approved:ApproveStatus) {
        self.appName = appName
        self.approved = approved
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(appName)
    }
}

//View that displays data for a single request.
struct AppRequestView: View {
    var request: RequestData
    var body: some View {
        ZStack {
            Image(systemName:"applelogo")
                .frame(maxWidth:.infinity, alignment:.leading)
            
            Text(request.appName)
                .frame(maxWidth:.infinity, alignment:.center)
            HStack {
                Image(systemName: "hand.thumbsup")
                    .foregroundColor(.green)
                Image(systemName: "hand.thumbsdown")
                    .foregroundColor(.red)
            }
            .frame(maxWidth:.infinity, alignment:.trailing)
        }
    }
}

struct StudentAppRequestView: View {
    @State private var searchAppName: String = ""
    var adminName = "Admin"
    
    @State var appList:[RequestData] = [
        RequestData(appName: "App 1", approved: ApproveStatus.unprocessed),
        RequestData(appName: "App 2", approved: ApproveStatus.approved),
        RequestData(appName: "App 3", approved: ApproveStatus.denied)
    ]
    
    var body: some View {
        VStack {
            Text("Main / Requests / " + adminName)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(5)
                .padding(.top, 8)
                .padding(.bottom, 40)
            
            Text("App Requests")
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
                        AppRequestView(request: request)
                    }
                }
            }
            .overlay(RoundedRectangle(cornerRadius:10, style:.circular)
                .stroke(lineWidth:3))
            .frame(maxWidth: UIScreen.main.bounds.size.width*0.85,
                   maxHeight: UIScreen.main.bounds.size.height*0.7)
            
            Button(action: {
                //should open list of apps installed on phone
                //user selects one to add a new request to appList
                //currently just adds to appList to demonstrate UI functionality
                var newAppName = "App " + String(appList.count)
                appList.append(RequestData(appName: newAppName, approved: ApproveStatus.unprocessed))
            }) {
                Text("+ New")
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(25)
            }
            .padding(.top, 10)
        }
    }
}

struct StudentAppRequestView_Previews: PreviewProvider {
    static var previews: some View {
        StudentAppRequestView()
    }
}
