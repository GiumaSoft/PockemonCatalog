//
//  NatureStatAffectSets.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

extension Model {
    struct NatureStatAffectSets: Decodable {
        let increase: NamedAPIResource
        let decrease: NamedAPIResource
    }
}
