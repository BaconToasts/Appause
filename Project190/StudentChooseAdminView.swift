//
//  ContentView.swift
//
//
//  Created by user on 4/6/23.
//

import SwiftUI

struct AdminEntry: View {
    var adminName: String = "New Class"
    var leftText: String = " - "
    var function: () -> Void
    
    var body: some View {
        HStack{
            Button(action: {
                self.function()}, label: {
                    Text(leftText)
                        .font(.system(size:30))
                        .font(Font.headline.weight(.bold))
            })
                .frame(alignment:.leading)
            
                Text(adminName)
                    .background(
                        NavigationLink(destination: StudentAppRequestView(adminName: adminName)
                            .navigationBarBackButtonHidden(true)) {}
                            .opacity(0) //This hides the arrow on the NavigationLink
                )
                    .font(.system(size:30))
                    .frame(maxWidth:.infinity, alignment:.center)
                    .overlay(RoundedRectangle(cornerRadius:6, style:.circular)
                        .stroke(lineWidth:3))
                    
                
                Image(systemName:"hand.raised.fill")
                .frame(alignment:.trailing)
                    .foregroundColor(.yellow)
                
            }
    }
}

struct StudentChooseAdminView: View {
    @State var adminList:[String] = [
        "Class 1",
        "Class 2",
        "Class 3"
    ]
    
    func addAdmin() {
        adminList.append("Class " + String(adminList.count + 1))
    }
    
    func removeAdmin(index: Int) {
        adminList.remove(at: index)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Main / Requests")
                    .padding()
                    .padding(.horizontal, 20)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .padding(.top, -30)
                
                
                List {
                    ForEach(Array(adminList.enumerated()), id:\.offset) { index, admin in
                        AdminEntry(adminName: admin, function: {() -> Void in removeAdmin(index: index)})
                            .padding(10)
                    }
                    AdminEntry(leftText: " + ", function: addAdmin)
                        .padding(10)
                }
                .frame(maxWidth: UIScreen.main.bounds.size.width*1,
                       maxHeight: UIScreen.main.bounds.size.height*0.7)
            }
        }
        .navigationBarBackButtonHidden(true)
        .buttonStyle(.plain)
    }
}

struct StudentChooseAdminView_Previews: PreviewProvider {
    static var previews: some View {
        StudentChooseAdminView()
    }
}
