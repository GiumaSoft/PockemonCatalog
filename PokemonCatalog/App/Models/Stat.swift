//
//  Stat.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

extension Model {
    struct Stat: Decodable {
        let id: Int
        let name: String
        let gameIndex: Int
        let isBattleOnly: Bool
        let affectingMoves: MoveStatAffectSets
        let affectingNatures: NatureStatAffectSets
        let characteristics: [APIResource]
        let moveDamageClass: NamedAPIResource
        let names: [Name]

        enum CodingKeys: String, CodingKey {
            case id, name, characteristics, names
            case gameIndex = "game_index"
            case isBattleOnly = "is_battle_only"
            case affectingNatures = "affecting_natures"
            case affectingMoves = "affecting_move"
            case moveDamageClass = "move_damage_class"
        }
    }
}
