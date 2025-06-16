//
//  PasswordCriteriaTest.swift
//  Password
//
//  Created by Alexis Horteales Espinosa on 15/06/25.
//

import XCTest

@testable import Password

class PasswordLenghtCriteriaTests: XCTestCase{
    
    // Boundary conditions 8-32
    func testShort() throws{
        XCTAssertFalse(PasswordCriteria.lenghtCriteriaMet("1234567"))
    }
    
    func testLong() throws{
        XCTAssertFalse(PasswordCriteria.lenghtCriteriaMet("123472387989x92839832983293289289328320023238032032"))
    }
    func testValidShort() throws{
        XCTAssertTrue(PasswordCriteria.lenghtCriteriaMet("123455678"))
    }
    func testValidLong() throws {
        XCTAssertTrue(PasswordCriteria.lenghtCriteriaMet("12345678901234567890123456789012"))
    }
}

class PasswordOtherCriteriaTest: XCTestCase{
    func testSpaceMet() throws{
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
    }
    
    func testSpaceNotMet() throws{
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("a bc"))
    }
    
    func testLengthAndNoSpaceMet() throws {
            XCTAssertTrue(PasswordCriteria.lenghtAndNoSpaceMet("12345678"))
        }

        func testLengthAndNoSpaceNotMet() throws {
            XCTAssertFalse(PasswordCriteria.lenghtAndNoSpaceMet("1234567 8"))
        }
        
        func testUpperCaseMet() throws {
            XCTAssertTrue(PasswordCriteria.uppercaseMet("A"))
        }

        func testUpperCaseNotMet() throws {
            XCTAssertFalse(PasswordCriteria.uppercaseMet("a"))
        }

        func testLowerCaseMet() throws {
            XCTAssertTrue(PasswordCriteria.lowercaseMet("a"))
        }

        func testLowerCaseNotMet() throws {
            XCTAssertFalse(PasswordCriteria.lowercaseMet("A"))
        }

        func testDigitMet() throws {
            XCTAssertTrue(PasswordCriteria.digitMet("1"))
        }

        func testDigitNotMet() throws {
            XCTAssertFalse(PasswordCriteria.digitMet("a"))
        }
        
        func testSpecicalCharMet() throws {
            XCTAssertTrue(PasswordCriteria.specialCharacterMet("@"))
        }

        func testSpecicalCharNotMet() throws {
            XCTAssertFalse(PasswordCriteria.specialCharacterMet("a"))
        }
}
