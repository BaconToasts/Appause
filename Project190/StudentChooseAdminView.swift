//
//  ContentView.swift
//
//
//  Created by user on 4/6/23.
//

import SwiftUI

struct StudentChooseAdminView: View {
    //Add this binding state for transitions from view to view
    @Binding var showNextView: DisplayState
    
    var adminList:[String] = [
        "Admin 1",
        "Admin 2",
        "Admin 3"
    ]
    
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action:{
                    withAnimation {
                        //show nextView .whateverViewYouWantToShow defined in ContentView Enum
                    showNextView = .mainStudent}
                })
                {
                    Text("Main / Classes")
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .padding(.top, -30)
                        .padding(.bottom, 30)
                    
                }
                
                ScrollView {
                    ForEach(adminList, id:\.self) { admin in
                        HStack{
                            NavigationLink("-", destination: StudentDeleteAdminView(adminName:admin)
                                .navigationBarHidden(true))
                                .font(.system(size:30))
                                .foregroundColor(.black)
                            NavigationLink(admin, destination: StudentAppRequestView(adminName: admin)
                                .navigationBarHidden(true))
                                .padding(10)
                                .font(.system(size:30))
                                .foregroundColor(.black)
                                .navigationBarHidden(true)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    NavigationLink(destination: StudentConnectCodeView()) {
                        HStack{
                            Text("+")
                            Text("New Class")
                        }
                        .padding(10)
                        .font(.system(size:30))
                        .foregroundColor(.black)
                    }
                    .navigationBarHidden(true)
                }
                .overlay(RoundedRectangle(cornerRadius:6, style:.circular)
                    .stroke(lineWidth:3))
                .frame(maxWidth: UIScreen.main.bounds.size.width*0.85,
                       maxHeight: UIScreen.main.bounds.size.height*0.7)
            }
        }
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct StudentChooseAdminView_Previews: PreviewProvider {
    @State static private var showNextView: DisplayState = .studentChooseAdmin

    static var previews: some View {
        StudentChooseAdminView(showNextView: $showNextView)
    }
}
