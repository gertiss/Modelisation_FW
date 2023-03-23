//
//  Atomes Swift.swift
//  JeuSudoku_FW
//
//  Created by Gérard Tisseau on 18/03/2023.
//

import Foundation

// MARK: - Atomes Swift

/// Les valeurs Swift de base : Int, Double, Bool  vérifient le protocole InstanciableParNom, et donc CodableEnLitteral. Ils sont dans l'univers "sémantique" des objets.
/// Leur représentation en littéral est une String.

/// Le type String est littéral 
extension String: UnLitteral {
    
    public var codeSwift: String {
        self.debugDescription
    }
    
}


extension Int: InstanciableParNom  {
    
    public var nom: String {
        String(self)
    }
    
    /// litteral est de la forme "123". On obtient un Int 123
    /// fatalError si syntaxe invalide
    public init(nom: String) {
        self = Int(nom)!
    }

}

extension Double: InstanciableParNom {

    public var nom: String {
        String(self)
    }
    
    /// litteral est de la forme "0.123", on obtient un Double 0.123
    /// fatalError si syntaxe invalide
    public init(nom: String) {
        self = Double(nom)!
    }

}

extension Bool: InstanciableParNom {
    
    public var nom: String {
        String(self)
    }
    
    /// litteral est de la forme "true" ou "false". On obtient un Bool true ou false.
    /// fatalError si syntaxe invalide
    public init(nom: String) {
        self = Bool(nom)!
    }

}

