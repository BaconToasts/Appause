//
//  PasswordRequirementsTests.swift
//  Project190Tests
//
//  Created by user on 10/26/23.
//

import XCTest
@testable import Project190

final class PasswordRequirementsTests: XCTestCase {

    func testPasswordRequirement() {
        // test passwords
        let passwords = ["Ch3rry!", "123", "fgh2", "d3ltaF05ce", "jashdj!shdfk", "Whyi5thisaPass"]
        let valid = Validate()
        
        // loop through passwords array
        for password in passwords {
            let check = valid.validatePassword(password)
            if (check == false){
                print(password + " is invalid password\n")
                XCTAssertFalse(check)
            }
            else{
                print(password + " is valid password\n")
                XCTAssertTrue(check)
            }
        }
    }
}
