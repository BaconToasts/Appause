//
//  ContentView.swift
//
//
//  Created by user on 4/6/23.
//

import SwiftUI

struct StudentChooseAdminView: View {
    var adminList:[String] = [
        "Admin 1",
        "Admin 2",
        "Admin 3"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Main / Requests")
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .padding(.top, -30)
                    .padding(.bottom, 40)
                
                
                List {
                    ForEach(adminList, id:\.self) { admin in
                        NavigationLink(destination: StudentAppRequestView(adminName: admin)) {
                            Text(admin)
                        }
                        .padding(10)
                        .font(.system(size:30))
                        .foregroundColor(.black)
                    }
                }
                .overlay(RoundedRectangle(cornerRadius:10, style:.circular)
                    .stroke(lineWidth:3))
                .frame(maxWidth: UIScreen.main.bounds.size.width*0.85,
                       maxHeight: UIScreen.main.bounds.size.height*0.7)
            }
        }
    }
}

struct StudentChooseAdminView_Previews: PreviewProvider {
    static var previews: some View {
        StudentChooseAdminView()
    }
}
