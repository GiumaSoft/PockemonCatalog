//
//  PokemonType.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 14/01/2021.
//

import Foundation

extension Model {
    struct PokemonType: Decodable {
        let slot: Int
        let type: NamedAPIResource
    }
}
