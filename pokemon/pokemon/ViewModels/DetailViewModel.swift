//
//  DetailViewModel.swift
//  pokemon
//
//  Created by 반성준 on 12/31/24.
//

import Foundation
import RxSwift

class DetailViewModel {
    private let networkManager = NetworkManager.shared

    func fetchPokemonDetail(pokemonId: Int) -> Single<Models.PokemonDetail> {
        // URL 생성
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonId)/") else {
            return .error(NSError(domain: "Invalid URL", code: -1, userInfo: nil))
        }

        // NetworkManager를 통해 데이터를 가져옴
        return networkManager.fetch(url: url)
    }
}
