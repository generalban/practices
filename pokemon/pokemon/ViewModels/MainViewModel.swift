//
//  MainViewModel.swift
//  pokemon
//
//  Created by 반성준 on 12/31/24.
//

import Foundation
import RxSwift
import RxRelay

final class MainViewModel {
    private let disposeBag = DisposeBag()
    private var offset = 0
    private let limit = 20
    private var isLoading = false
    
    let pokemonList = BehaviorRelay<[Models.Pokemon]>(value: [])
    
    func fetchPokemonList() {
        guard !isLoading else { return }
        isLoading = true
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)")!
        
        NetworkManager.shared.fetch(url: url)
            .subscribe(onSuccess: { [weak self] (list: Models.PokemonListResponse) in
                guard let self = self else { return }
                self.offset += self.limit
                let updatedList = self.pokemonList.value + list.results
                self.pokemonList.accept(updatedList)
                self.isLoading = false
            }, onFailure: { [weak self] _ in
                self?.isLoading = false
            })
            .disposed(by: disposeBag)
    }
}
