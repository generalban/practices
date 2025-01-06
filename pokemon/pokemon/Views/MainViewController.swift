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

final class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
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
        setupBindings()
        viewModel.fetchPokemonList()
    }
    
    private func setupUI() {
        view.backgroundColor = .mainRed
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        collectionView.backgroundColor = .darkRed
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: "PokemonCell")
    }
    
    private func setupBindings() {
        viewModel.pokemonList
            .bind(to: collectionView.rx.items(cellIdentifier: "PokemonCell", cellType: PokemonCollectionViewCell.self)) { _, model, cell in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Models.Pokemon.self)
            .subscribe(onNext: { [weak self] pokemon in
                let detailVC = DetailViewController(pokemon: pokemon)
                self?.navigationController?.pushViewController(detailVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.contentOffset
            .filter { [weak self] offset in
                guard let self = self else { return false }
                return self.collectionView.isNearBottomEdge(offset: offset)
            }
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.fetchPokemonList()
            })
            .disposed(by: disposeBag)
    }
}

private extension UIScrollView {
    func isNearBottomEdge(offset: CGPoint) -> Bool {
        return contentOffset.y + frame.size.height + 100 > contentSize.height
    }
}
