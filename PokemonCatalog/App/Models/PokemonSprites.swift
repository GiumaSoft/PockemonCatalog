//
//  PokemonSprites.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 14/01/2021.
//

import Foundation

extension Model {
    struct PokemonSprites {
        let frontDefault: URL?
        let backDefault: URL?
    }
}

extension Model.PokemonSprites: Decodable {
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case backDefault = "back_default"
    }

    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Model.PokemonSprites.CodingKeys> = try decoder.container(keyedBy: Model.PokemonSprites.CodingKeys.self)
        self.frontDefault = try {
            guard let urlString = try container.decodeIfPresent(String.self, forKey: Model.PokemonSprites.CodingKeys.frontDefault) else { return nil }
            return URL(string: urlString)
        }()
        self.backDefault = try {
            guard let urlString = try container.decodeIfPresent(String.self, forKey: Model.PokemonSprites.CodingKeys.backDefault) else { return nil }
            return URL(string: urlString)
        }()
    }
}
