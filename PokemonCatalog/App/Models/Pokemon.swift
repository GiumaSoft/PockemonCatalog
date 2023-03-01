//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 14/01/2021.
//

import Foundation

extension Model {
    struct Pokemon: Decodable {
        let id: Int
        let name: String
        let sprites: PokemonSprites
        let stats: [PokemonStat]
        let types: [PokemonType]
    }
}

extension Model.Pokemon: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Model.Pokemon, rhs: Model.Pokemon) -> Bool {
        lhs.id == rhs.id
    }
}
