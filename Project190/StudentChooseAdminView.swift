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
                        ZStack {
                            NavigationLink("-", destination: StudentDeleteAdminView(adminName: admin)
                                .navigationBarHidden(true))
                                .font(.system(size:30))
                                .frame(maxWidth:.infinity, alignment:.leading)
                                .padding(.leading, 5)
                                .foregroundColor(.black)
                            
                            Text(admin)
                                .font(.system(size:25))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth:.infinity, alignment:.center)
                                .foregroundColor(.black)
                            
                            NavigationLink(destination: StudentAppRequestView(adminName: admin)
                                .navigationBarHidden(true)) {
                                Image(systemName: "hand.raised.fill")
                                    .foregroundColor(Color.yellow)
                            }
                                .padding(.trailing, 5)
                                .frame(maxWidth:.infinity, alignment:.trailing)
                                .font(.system(size:30))
                        }
                            .padding(5)
                    }
                    
                    NavigationLink(destination: StudentConnectCodeView()
                        .navigationBarHidden(true)) {
                        ZStack{
                            Text("+")
                                .font(.system(size:30))
                                .frame(maxWidth:.infinity, alignment:.leading)
                                .padding(.leading, 5)
                            Text("New Class")
                                .frame(maxWidth:.infinity, alignment:.center)
                                .font(.system(size:25))
                        }
                            .padding(5)
                            .foregroundColor(.black)
                    }
                }
                .overlay(RoundedRectangle(cornerRadius:6, style:.circular)
                    .stroke(lineWidth:3))
                .frame(maxWidth: UIScreen.main.bounds.size.width*0.85,
                       maxHeight: UIScreen.main.bounds.size.height*0.7)
            }
        }
    }
}

struct StudentChooseAdminView_Previews: PreviewProvider {
    @State static private var showNextView: DisplayState = .studentChooseAdmin

    static var previews: some View {
        StudentChooseAdminView(showNextView: $showNextView)
    }
}
