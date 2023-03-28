//
//  DecodableEnObjet.swift
//  Modelisation_FW
//
//  Created by Gérard Tisseau on 28/03/2023.
//

import Foundation

/// Permet de retrouver l'objet associé au littéral.
protocol DecodableEnObjet: UnLitteral {
    
    associatedtype Objet: CodableEnLitteral where Objet.Litteral == Self
    
    var objet: Objet { get }
}

extension DecodableEnObjet {
    
    var objet: Objet {
        Objet(litteral: self)
    }
}
