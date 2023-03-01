//
//  NamedAPIResource.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 14/01/2021.
//

import Foundation

extension Model {
    struct NamedAPIResource: Decodable {
        /// The name of the referenced resource.
        let name: String
        /// The URL of the referenced resource.
        let url: URL?

        enum CodingKeys: CodingKey {
            case name
            case url
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<Model.NamedAPIResource.CodingKeys> = try decoder.container(keyedBy: Model.NamedAPIResource.CodingKeys.self)
            self.name = try container.decode(String.self, forKey: Model.NamedAPIResource.CodingKeys.name)
            self.url = URL(string: try container.decode(String.self, forKey: Model.NamedAPIResource.CodingKeys.url))
        }
    }
}
