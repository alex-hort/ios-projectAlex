//
//  ProfileTest.swift
//  BankeyUnitTests
//
//  Created by Alexis Horteales Espinosa on 26/05/25.
//



import Foundation
import XCTest

@testable import Bankey

class ProfileTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
        {
        "id": "1",
        "first_name": "Kevin",
        "last_name": "Flynn",
        }
        """
        
        let data = json.data(using: .utf8)!
        let result = try! JSONDecoder().decode(Profile.self, from: data)
        
        XCTAssertEqual(result.id, "1")
        XCTAssertEqual(result.firstName, "Kevin")
        XCTAssertEqual(result.lastName, "Flynn")
    }
}
