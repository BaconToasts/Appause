//
//  Project190App.swift
//  Project190
//
//  Created by Vlad Puriy on 4/10/23.
//

import SwiftUI
import Firebase

@main
struct Project190App: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
