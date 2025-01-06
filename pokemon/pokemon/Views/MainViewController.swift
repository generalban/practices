//
//  MainViewController.swift
//  pokemon
//
//  Created by 반성준 on 12/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()

    // CollectionView 및 레이아웃 정의
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchPokemonList(limit: 20, offset: 0)
    }

    // UI 설정
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        collectionView.backgroundColor = .white
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
    }

    // ViewModel 바인딩 처리
    private func bindViewModel() {
        // 셀 데이터 바인딩
        viewModel.pokemonList
            .bind(to: collectionView.rx.items(cellIdentifier: PokemonCollectionViewCell.identifier, cellType: PokemonCollectionViewCell.self)) { _, model, cell in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)

        // 셀 선택 이벤트 처리
        collectionView.rx.modelSelected(Models.Pokemon.self)
            .subscribe(onNext: { pokemon in
                print("Selected Pokemon: \(pokemon.name)")
            })
            .disposed(by: disposeBag)
    }
}
