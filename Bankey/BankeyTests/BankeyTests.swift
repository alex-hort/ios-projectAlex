//
//  BankeyTests.swift
//  BankeyTests
//
//  Created by Alexis Horteales Espinosa on 26/04/25.
//

import XCTest
import UIKit

 
@testable import Bankey
// Import the Bankey module with @testable so that you can access internal properties and methods for testing.

class BankeyTests: XCTestCase {
    // Define a test class that inherits from XCTestCase, the base class for writing unit tests in Xcode.
    var vc: LoginViewController!
    // Declare a variable to hold the instance of LoginViewController you want to test.
    override func setUp() {
        super.setUp()
        // Call the superclass’s setUp method first (good practice).
        vc = LoginViewController()
        // Create an instance of LoginViewController.
        vc.loadViewIfNeeded()
        // Force the view to load.
    }
    func testShouldBeVisible() throws {
        // Define a test function named "testShouldBeVisible".
        let isViewLoaded = vc.isViewLoaded
        // Check if the view has been loaded.

        XCTAssertTrue(isViewLoaded)
        // Assert that isViewLoaded is true.
    }
}
