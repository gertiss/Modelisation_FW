//
//  New.swift
//  Modelisation_FW
//
//  Created by Gérard Tisseau on 29/03/2023.
//

import Foundation

struct Personne: CodableEnLitteral, Equatable, AvecLangage {
    
    typealias Litteral = Personne_
    
    let nom: String
    let age: Int
    
    var litteral: Personne_ {
        .init(nom: nom, age: age)
    }
    
    init(nom: String, age: Int) {
        self.nom = nom
        self.age = age
    }
    
    init(litteral: Personne_) {
        self.nom = litteral.nom
        self.age = litteral.age
    }
    
    var codeSwift: String {
        "\(self)"
    }
}

struct Personne_: UnLitteral, Equatable, Codable, Hashable  {
    let nom: String
    let age: Int
    
    var codeSwift: String {
        "\(self)"
    }
    
    /// Rend self si succès et un message d'erreur si échec
    var valide: Result<Self, String> {
        guard nom.count <= 30 else {
            return .failure("Personne_: le nom ne doit pas avoir plus de 30 caractères, et pas \"\(age)\"")
        }
        guard age >= 0 && age <= 120 else {
            return .failure("Personne_: age doit être entre 0 et 120 et pas \(age)")
        }
        return .success(self)
    }
}

extension Personne_: AvecLangage {
    var source: String {
        "\(nom), \(age)"
    }
    
    init(source: String) {
        let champs = source.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        assert(champs.count == 2)
        self.nom = champs[0]
        self.age = Int(champs[1])!
    }
    
}
