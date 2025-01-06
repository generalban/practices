//
//  PokemonListResponse.swift
//  pokemon
//
//  Created by 반성준 on 1/3/25.
//

import Foundation

enum Models {
    struct PokemonListResponse: Decodable {
        let results: [Pokemon]
    }

    struct Pokemon: Decodable {
        let name: String
        let url: String
    }

    struct PokemonDetail: Decodable {
        let id: Int
        let name: String
        let height: Int
        let weight: Int
        let types: [PokemonType]

        struct PokemonType: Decodable {
            let type: TypeInfo
            
            struct TypeInfo: Decodable {
                let name: String
            }
        }
    }

}
