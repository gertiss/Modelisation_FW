//
//  Extension Swift.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 12/01/2023.
//

import Foundation

// MARK: - String

extension String: Error {
    
    public var localizedDescription: String {
        self
    }
}

public extension String {
    
    func avecSuppression(de caracteres: String) -> String {
        var copie = self
        copie.removeAll { caracteres.contains($0) }
        return copie
    }
    
    var avecSuppressionEspacesTabsNewlines: String {
        avecSuppression(de: " \t\n")
    }
}


// MARK: - Result

/// Accès directs pratiques à un Result
public extension Result where Failure == String {
    
    var estSucces: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }
    
    var estEchec: Bool {
        switch self {
        case .success: return false
        case .failure: return true
        }

    }
    
    /// description de la valeur ou message d'erreur
    var texte: String {
        switch self {
        case .success(let v): return "\(v)"
        case .failure(let message): return message
        }
    }

    var valeur: Success? {
        switch self {
        case .success(let v): return v
        case .failure: return nil
        }
    }

    var erreur: String? {
        switch self {
        case .success: return nil
        case .failure(let message): return message
        }
    }

}

// MARK: - Array

/// Conversions Array-Set
public extension Array where Element: Hashable {
    var ensemble: Set<Element> {
        Set(self)
    }
    
    /// Le nombre d'éléments distincts
    var cardinal: Int {
        ensemble.count
    }
    
    /// `[1] -> 1, [1, 1] -> 1, [1, 2] -> nil`
    var uniqueValeur: Element? {
        ensemble.uniqueValeur
    }
    
    /// fatalError si cardinal != 1
    /// `[1] -> 1, [1, 1] -> 1, [1, 2] -> fatalError`
    var uniqueElement: Element {
        ensemble.uniqueElement
    }
    
    /// `[1, 2, 1] -> [1, 2]`
    var sansDoublons: Self {
        ensemble.array
    }
}

public extension Array where Element: Hashable & Comparable {
    
    /// Elimine les doublons et ordonne le résultat.
    ///`[2, 1, 2] -> [1, 2]`
    var compact: Self {
        ensemble.array.sorted()
    }
}


// MARK: - Set

public extension Set {
    
    /// Lorsque l'ensemble est un singleton, on retourne l'unique élément.
    /// Erreur sinon
    var uniqueElement: Element {
        assert(count == 1)
        return map{$0}[0]
    }
    
    /// Lorsque l'ensemble est un singleton, on retourne l'unique élément.
    /// nil sinon
    var uniqueValeur: Element? {
        if count != 1 { return nil }
        let liste: [Element] = self.map { $0 }
        return liste[0]
    }

    var array: [Element] {
        map { $0 }
    }
    
    var cardinal: Int {
        count
    }
}

public extension Set where Element: Comparable {
    
    func sorted() -> [Element] {
        array.sorted()
    }
}

// MARK: - Dictionary

public extension Dictionary {
    
    /// On ajoute l'élément à la valeur de la clé, lorsque cette valeur est un ensemble
    mutating func ajouter<E>(_ element: E, a cle: Key) where Value == Set<E> {
        guard var ensemble = self[cle] else {
            self[cle] = [element]
            return
        }
        ensemble.insert(element)
        self[cle] = ensemble
    }
}

// MARK: - Int

public extension Int {

    static let lesChiffres1a9 = Set([1, 2, 3, 4, 5, 6, 7, 8, 9])
}


