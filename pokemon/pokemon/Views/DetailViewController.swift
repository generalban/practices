//
//  DetailViewController.swift
//  pokemon
//
//  Created by 반성준 on 12/31/24.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    private let viewModel = DetailViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
    }

    func configure(with pokemonId: Int) {
        viewModel.fetchPokemonDetail(pokemonId: pokemonId)
            .subscribe(onSuccess: { detail in
                print("Pokemon Detail: \(detail)")
            }, onFailure: { error in
                print("Error: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}
