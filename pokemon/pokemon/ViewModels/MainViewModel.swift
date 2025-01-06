//
//  MainViewModel.swift
//  pokemon
//
//  Created by 반성준 on 12/31/24.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    private let networkManager = NetworkManager.shared
    private let disposeBag = DisposeBag()

    // 네임스페이스 사용
    let pokemonList = BehaviorRelay<[Models.Pokemon]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)

    func fetchPokemonList(limit: Int, offset: Int) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)") else { return }

        isLoading.accept(true)

        networkManager.fetch(url: url)
            .subscribe(onSuccess: { [weak self] (response: Models.PokemonListResponse) in
                self?.pokemonList.accept(response.results)
                self?.isLoading.accept(false)
            }, onFailure: { [weak self] error in
                print("Error fetching pokemon: \(error.localizedDescription)")
                self?.isLoading.accept(false)
            })
            .disposed(by: disposeBag)
    }
}
