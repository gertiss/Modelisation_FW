//
//  Collections Swift.swift
//  PlusMoins_FW
//
//  Created by Gérard Tisseau on 22/03/2023.
//

import Foundation

// MARK: - Array

/// Les protocoles AvecCodeSwift, Codable, CodableEnJson, CodableEnLitteral se transmettent aux Array

extension Array: AvecCodeSwift where Element: AvecCodeSwift {
        
    public var codeSwift: String {
        "[\(map{ $0.codeSwift }.joined(separator: ", "))]"
    }
}

extension Array: CodableEnJson where Element: Codable { }


extension Array: CodableEnLitteral where Element: CodableEnLitteral, Element.Litteral: Codable {
    
    /// Pour pouvoir définir Self.Litteral
    public typealias Litteral = [Element.Litteral]
    
    public var litteral: [Element.Litteral] {
        map { $0.litteral }
    }
    
    public init(litteral: [Element.Litteral]) {
        self = litteral.map { Element(litteral: $0) }
    }
}

// MARK: - Set
// Sous-entend que Element est Hashable

extension Set: AvecCodeSwift where Element: Hashable & AvecCodeSwift{
        
    public var codeSwift: String {
        "Set([\(map{ $0.codeSwift }.joined(separator: ", "))])"
    }
}

extension Set: CodableEnJson where Element: Hashable & Codable { }

extension Set: CodableEnLitteral where Element: Hashable & CodableEnLitteral, Element.Litteral: Codable {
    
    /// Pour pouvoir définir Self.Litteral
    public typealias Litteral = [Element.Litteral]
    
    public var litteral: [Element.Litteral] {
        map { $0.litteral }
    }
    
    public init(litteral: [Element.Litteral]) {
        self = litteral.map { Element(litteral: $0) }.ensemble
    }
}

