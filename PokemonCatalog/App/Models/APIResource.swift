//
//  APIResource.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

extension Model {
    struct APIResource: Decodable {
        let url: String                     // The URL of the referenced resource.
    }
}
