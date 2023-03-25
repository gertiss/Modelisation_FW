//
//  AvecLangage.swift
//  Modelisation_FW
//
//  Created by Gérard Tisseau on 23/03/2023.
//

import Foundation

/// Peut être écrit et relu suivant une String
public protocol AvecLangage {
    var source: String { get }
    init(source: String)
}
