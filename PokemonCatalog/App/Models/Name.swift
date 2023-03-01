//
//  Name.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

extension Model {
    struct Name: Decodable {
        let name: String
        let language: NamedAPIResource
    }
}
