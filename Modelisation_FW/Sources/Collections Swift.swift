//
//  Collections Swift.swift
//  PlusMoins_FW
//
//  Created by Gérard Tisseau on 22/03/2023.
//

import Foundation

/// Un Array de littéraux est un littéral
extension Array: UnLitteral, Comparable, Identifiable, CodableEnJson where Element: UnLitteral {
        
    public var codeSwift: String {
        "[\(map{ $0.codeSwift }.joined(separator: ", "))]"
    }
}

/// Un Array de CodableEnLitteral possède les fonctions de CodableEnLitteral.
/// mais il semble impossible de lui faire vérifier le protocole CodableEnLitteral,
/// sans doute à cause de conflits avec des protocoles par défaut dans Swift pour Array
extension Array where Element: CodableEnLitteral {
    
    /// Pour pouvoir définir Self.Litteral
    public typealias Litteral = [Element.Litteral]

    public var litteral: [Element.Litteral] {
        map { $0.litteral }
    }

    public init(litteral: [Element.Litteral]) {
        self = litteral.map { Element(litteral: $0) }
    }
    
    /// Protocole Identifiable
    public var id: Litteral {
        litteral
    }
    
    /// Protocole Comparable.
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.litteral < rhs.litteral
    }

    // MARK: Protocole CodableEnJson
    
    public var json: String {
        litteral.json
    }
    
    public var jsonResult: Result<String, String> {
        litteral.jsonResult
    }
    
    public func jsonThrows() throws -> String {
        try litteral.jsonThrows()
    }

    public static func avecJsonResult(_ json: String) -> Result<Self, String> {
        let litteral = Self.Litteral.avecJsonResult(json)
        switch litteral {
        case .success(let arrayLitteral):
            return .success(Self(litteral: arrayLitteral))
        case .failure(let erreur):
            return .failure(erreur)
        }
    }
    
    public static func avecJsonThrows(_ json: String) throws -> Self {
        switch avecJsonResult(json) {
        case.success(let array):
            return array
        case .failure(let erreur):
            throw erreur
        }
    }

    /// decode depuis json ou sinon fatalError()
    static func avecJson(_ json: String) -> Self {
        try! avecJsonThrows(json)
    }

}
