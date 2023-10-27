//
//  RequestData.swift
//  Project190
//
//  Created by UserSSD on 10/27/23.
//

import SwiftUI

enum ApproveStatus {
    case approved
    case approvedTemporary
    case denied
    case unprocessed
}

struct RequestData: Hashable, Identifiable {
    let id = UUID()
    var appName: String
    var appDescription: String
    var approved: ApproveStatus
    var approvedDuration: Float
    
    init(appName:String, approved:ApproveStatus) {
        self.appName = appName
        self.approved = approved
        self.appDescription = "Generic App Description"
        self.approvedDuration = .infinity
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(appName)
    }
}

struct AppThumb: View {
    @State var approveStatus: ApproveStatus = .unprocessed
    
    var body : some View {
        switch self.approveStatus {
        case .approved:
            Image(systemName: "hand.thumbsup.fill")
                .foregroundColor(.green)
        case .approvedTemporary:
            Image(systemName: "hand.thumbsup.fill")		
                .foregroundColor(.yellow)
        case .denied:
            Image(systemName: "hand.thumbsdown.fill")
                .foregroundColor(.red)
        case .unprocessed:
            Image(systemName: "hand.thumbsup")
                .foregroundColor(.gray)
        }
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
            AppThumb(approveStatus: request.approved)
            .frame(maxWidth:.infinity, alignment:.trailing)
        }
    }
}
