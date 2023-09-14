//
//  ContentView.swift
//  MainTeacherPage
//
//  Created by user on 4/6/23.
//

import SwiftUI

// add aditional display states here for additional View transitions
enum DisplayState {
    case eula, login, mainTeacher, mainStudent, connectCode, teacherMasterControl, logout, studentConnectCode, studentSettings, teacherSettings, teacherDeleteStudent, studentDeleteAdmin, studentChooseAdmin, teacherAppRequest, teacherManageUsers
}

struct ContentView: View {
    @State private var displayState: DisplayState = .eula

    var body: some View {
        VStack {
            //add DisplayState transitions here
            switch displayState {
            case .eula:
                EULAView(showNextView: $displayState)
            case .login:
                LoginView(showNextView: $displayState)
            case .mainStudent:
                StudentMainView(showNextView: $displayState)
            case .mainTeacher:
                TeacherMainView(showNextView: $displayState)
            case .connectCode:
                TeacherConnectCodeView(showNextView: $displayState)
            case .studentConnectCode:
                StudentConnectCodeView()
            case .teacherMasterControl:
                TeacherMasterControlView(showNextView: $displayState)
            case .logout :
                LoginView(showNextView: $displayState)
            case .studentSettings:
                StudentSettingsView(showNextView: $displayState)
            case .teacherSettings:
                TeacherSettingsView(showNextView: $displayState)
            case .teacherDeleteStudent:
                TeacherDeleteStudentView(showNextView: $displayState)
            case .studentDeleteAdmin:
                StudentDeleteAdminView()
            case .studentChooseAdmin:
                StudentChooseAdminView(showNextView: $displayState)
            case .teacherAppRequest:
                TeacherAppRequestView(showNextView: $displayState )
            case .teacherManageUsers:
                TeacherManageUsers(showNextView: $displayState)
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    //shows the first state
    @State static private var showNextView: DisplayState = .eula
    
    static var previews: some View {
        ContentView()
    }
}
