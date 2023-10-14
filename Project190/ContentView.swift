//
//  ContentView.swift
//  MainTeacherPage
//
//  Created by user on 4/6/23.
//

import SwiftUI

// add aditional display states here for additional View transitions
enum DisplayState {

    case eula, login, emailCode, mainTeacher, mainStudent, connectCode, teacherMasterControl, logout, studentConnectCode, studentSettings, teacherSettings, teacherDeleteStudent, studentDeleteAdmin, studentChooseAdmin, studentRegister, teacherRegister, selectRegistration, resetPassword, teacherAppRequest, teacherManageUsers, teacherWhitelist, twoFactorAuth, pWCodeVerification

}

struct ContentView: View {
    @State private var displayState: DisplayState = .eula
    @State private var email: String = "test@example.com"
    @State private var show2FAInput: Bool = true // Add this line
    
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
                TeacherDeleteStudentView()
            case .studentDeleteAdmin:
                StudentDeleteAdminView()
            case .studentChooseAdmin:
                StudentChooseAdminView(showNextView: $displayState)
            case .teacherAppRequest:
                TeacherAppRequestView()
            case .teacherWhitelist:
                TeacherWhitelist()
            case .resetPassword:
                ResetPasswordView(showNextView: $displayState)
            case .teacherManageUsers:
                TeacherManageUsers()
            case .studentRegister:
                StudentRegisterView(showNextView: $displayState)
            case .teacherRegister:
                TeacherRegisterView(showNextView: $displayState)
            case .selectRegistration:
                SelectRegistrationView(showNextView: $displayState)
            case .emailCode:
                EmailCodeView(showNextView: $displayState)
            case .pWCodeVerification:
                PWCodeVerificationView(showNextView: $displayState)
            case .twoFactorAuth:
                TwoFactorAuthView(showNextView: $displayState, email: email, onVerificationSuccess: {
                    // You can add actions here that should be performed on successful verification
                    print("Verification successful!")}, show2FAInput: $show2FAInput)

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
