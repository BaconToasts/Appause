//
//  ContentView.swift
//  MasterControlPage
//
//  This tool enables the admin to temporarily override
//  any and all approved or denied request for registered user
//

import SwiftUI

struct TeacherMasterControlView: View {
    //Add this binding state for transitions from view to view
    @Binding var showNextView: DisplayState
    
    @State private var status: String = ""
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
            //make button show nextView .whateverViewYouWantToShow defined in ContentView Enum
                    showNextView = .mainTeacher}
            }){// Text displaying our current path
                Text("MAIN / MASTER CONTROL")
                    .padding()
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
            //spacer to push button above it to the top. The higher the height value
            // the more it is pushed to the top. Lower closer to center
            Spacer().frame(height:500)
            // Text displaying the current status of our app with normal meaning unlocked
            Text(status)
                .multilineTextAlignment(.center)
                .font(.title)
                .foregroundColor(.black)
                
            
            // Had to use HStack to align buttons horizontally
            HStack {
                VStack {
                    // Clicking on this button locks all apps from a student's phone
                    Button(action: {
                        status = "Status: Locked"
                    }, label: {
                        Image(systemName: "lock")
                            .padding(.trailing)
                            .font(.system(size: 100))
                            .foregroundColor(.red)
                    })
                    Text("Lock")
                        .padding(.trailing)
                }
                VStack {
                    // Clicking on this button unlocks all apps from a student's phone
                    Button(action: {
                        status = "Status: Unlocked"
                    }, label: {
                        Image(systemName: "lock.open")
                            .padding(.leading)
                            .font(.system(size: 100))
                            .foregroundColor(.green)
                    })
                    Text("Unlock")
                }
            }
        }
    }
}

struct TeacherMasterControlView_Previews: PreviewProvider {
    @State static private var showNextView: DisplayState = .teacherMasterControl
    
    static var previews: some View {
        TeacherConnectCodeView(showNextView: $showNextView)
    }
    
}
