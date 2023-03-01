//
//  MoveStatAffectSets.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

extension Model {
    struct MoveStatAffectSets: Decodable {
        let increase: MoveStatAffect
        let decrease: MoveStatAffect
    }
}
