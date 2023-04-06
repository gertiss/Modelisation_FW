//
//  Atomes Swift.swift
//  JeuSudoku_FW
//
//  Created by Gérard Tisseau on 18/03/2023.
//

import Foundation

// MARK: - Atomes Swift

// Ce sont à la fois des littéraux et des objets qui sont leur propre littéral.
// Leur codeSwift est leur description, sauf pour String, où c'est la debugDescription
// Ils sont automatiquement CodableEnJson car Codable.

extension String: UnLitteral, CodableEnLitteral {
    
    public typealias Litteral = Self
    
    /// Le codeSwift de `"abc"` est `"\"abc\""`
    public var codeSwift: String {
        self.debugDescription
    }
    
    public var litteral: String {
        self
    }
    
    public init(litteral: String) {
        self = litteral
    }
    
}

extension Int: UnLitteral, CodableEnLitteral {
    
    public typealias Litteral = Self

    public var codeSwift: String {
        self.description
    }

    /// nom est de la forme "123". On obtient un Int 123
    /// fatalError si syntaxe invalide
    public init(codeSwift: String) {
        self = Int(codeSwift)!
    }
    
    public var litteral: Int {
        self
    }
    
    public init(litteral: Int) {
        self = litteral
    }


}

extension Double: UnLitteral, CodableEnLitteral {
    
    public typealias Litteral = Self

    public var codeSwift: String {
        self.description
    }

    /// nom est de la forme "0.123", on obtient un Double 0.123
    /// fatalError si syntaxe invalide
    public init(codeSwift: String) {
        self = Double(codeSwift)!
    }
    
    public var litteral: Double {
        self
    }
    
    public init(litteral: Double) {
        self = litteral
    }


}

extension Bool: UnLitteral, CodableEnLitteral {
    
    public typealias Litteral = Self

    public var codeSwift: String {
        self.description
    }

    /// nom est de la forme "true" ou "false". On obtient un Bool true ou false.
    /// fatalError si syntaxe invalide
    public init(codeSwift: String) {
        self = Bool(codeSwift)!
    }
    
    public var litteral: Bool {
        self
    }
    
    public init(litteral: Bool) {
        self = litteral
    }

}

