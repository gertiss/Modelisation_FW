//
//  Modelisation_FWTests.swift
//  Modelisation_FWTests
//
//  Created by Gérard Tisseau on 22/03/2023.
//

import XCTest
@testable import Modelisation_FW

final class Modelisation_FWTests: XCTestCase {

    override func setUpWithError() throws {
        print()
    }

    override func tearDownWithError() throws {
        print()
    }

    func testUnAtome() {
        XCTAssertEqual(1.nom, "1")
        XCTAssertEqual(0.1.nom, "0.1")
        XCTAssertEqual(true.nom, "true")
        XCTAssertEqual(false.nom, "false")
        
        XCTAssertEqual(Int(nom: "1"), 1)
        XCTAssertEqual(Double(nom: "0.1"), 0.1)
        XCTAssertEqual(Bool(nom: "true"), true)
        XCTAssertEqual(Bool(nom: "false"), false)
        
        XCTAssertEqual("abc".codeSwift, "\"abc\"")
   }
    
}
