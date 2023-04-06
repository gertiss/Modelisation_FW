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
        XCTAssertEqual("abc".codeSwift, "\"abc\"")
        XCTAssertEqual(1.codeSwift, "1")
        XCTAssertEqual(0.1.codeSwift, "0.1")
        XCTAssertEqual(true.codeSwift, "true")
        XCTAssertEqual(false.codeSwift, "false")
        
        XCTAssertEqual(Int(codeSwift: "1"), 1)
        XCTAssertEqual(Double(codeSwift: "0.1"), 0.1)
        XCTAssertEqual(Bool(codeSwift: "true"), true)
        XCTAssertEqual(Bool(codeSwift: "false"), false)
        
        
        XCTAssertEqual("abc".litteral, "abc")
        XCTAssertEqual(1.litteral, 1)
        XCTAssertEqual(0.1.litteral, 0.1)
        XCTAssertEqual(true.litteral, true)
        XCTAssertEqual(false.litteral, false)

        
   }
    
    func testPersonne() {
        let toto = Personne(nom: "Toto", age: 10)
        print(toto)
        print(toto.codeSwift)
        print(toto.source.debugDescription)
        XCTAssertEqual(Personne(source: toto.source), toto)

        let toto_ = toto.litteral
        print(toto_)
        XCTAssertEqual(Personne_(source: toto_.source), toto_)
        XCTAssertEqual(toto_.json, "{\"nom\":\"Toto\",\"age\":10}")
        
        print(Set([toto_, toto_]).codeSwift)

   }
    
}
