//
//  InstanciableParNom.swift
//  JeuSudoku_FW
//
//  Created by Gérard Tisseau on 02/02/2023.
//

import Foundation

/// Tout type vérifiant InstanciableParNom peut créer ses instances à partir d'un "nom" String
/// Le nom définit une sorte de langage de sérialisation permettant de lire et écrire la valeur sous forme compacte.
/// C'est un cas particulier de CodableEnLitteral, avec litteral = nom.
/// C'est un cas particulier de AvecLangage, avec source = nom.
public protocol InstanciableParNom:  AvecLangage {
    
    var nom: String { get }
    init(nom: String)
}

public extension InstanciableParNom {
    
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

