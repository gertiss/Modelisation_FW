//
//  Atomes Swift.swift
//  JeuSudoku_FW
//
//  Created by Gérard Tisseau on 18/03/2023.
//

import Foundation

// MARK: - Atomes Swift

/// Le type String est UnLitteral, mais pas CodableEnLitteral.
extension String: UnLitteral {
    
    /// Le codeSwift de `"abc"` est `"\"abc\""`
    public var codeSwift: String {
        self.debugDescription
    }
    
}

/// N'hérite pas de InstanciableParNom ni de CodableEnLitteral mais en a les méthodes
/// Le but est d'éviter des conflits avec les méthodes par défaut pour descriptiion
public protocol UnAtome: AvecLangage {
    var nom: String { get }
    init(nom: String)
}

public extension UnAtome {
        
    var litteral: String {
        nom
    }
    
    init(litteral: String) {
        self = Self(nom: litteral)
    }
    
    var source: String {
        nom
    }
    
    init(source: String) {
        self = Self(nom: source)
    }
}

extension Int: UnAtome {

    public var nom: String {
        String(self)
    }

    /// nom est de la forme "123". On obtient un Int 123
    /// fatalError si syntaxe invalide
    public init(nom: String) {
        self = Int(nom)!
    }

}

extension Double: UnAtome {

    public var nom: String {
        String(self)
    }

    /// nom est de la forme "0.123", on obtient un Double 0.123
    /// fatalError si syntaxe invalide
    public init(nom: String) {
        self = Double(nom)!
    }

}

extension Bool: UnAtome {

    public var nom: String {
        String(self)
    }

    /// nom est de la forme "true" ou "false". On obtient un Bool true ou false.
    /// fatalError si syntaxe invalide
    public init(nom: String) {
        self = Bool(nom)!
    }

}

