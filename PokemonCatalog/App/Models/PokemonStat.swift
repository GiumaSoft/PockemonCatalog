//
//  PokemonStat.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 14/01/2021.
//

import Foundation

extension Model {
    struct PokemonStat: Decodable {
        let stat: NamedAPIResource                                    // The name for this resource.
        let effort: Int
        let baseStat: Int

        enum CodingKeys: String, CodingKey {
            case stat, effort
            case baseStat = "base_stat"
        }
    }
}
