//
//  CodableEnLitteral.swift
//  JeuSudoku_FW
//
//  Created by Gérard Tisseau on 10/03/2023.
//

import Foundation


/// Un type CodableEnLitteral possède une propriété `litteral` conforme au protocole `UnLitteral`.
public protocol CodableEnLitteral {
    associatedtype Litteral: UnLitteral
    
    var litteral: Litteral { get }
    
    init(litteral: Litteral)
}


/// Si le litteral est conforme à AvecLangage, on peut déclarer l'objet concret conforme à AvecLangage
extension CodableEnLitteral where Litteral: AvecLangage {
    
    public var source: String {
        litteral.source
    }
    
    public init(source: String) {
        self = Self(litteral: Litteral(source: source))
    }
    
}
