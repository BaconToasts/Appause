//
//  User.swift
//  Project190
//
//  Created by Navjit on 10/26/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    
    /*
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
     */
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Jon Jones", email: "jonjones@ufc.com")
}
