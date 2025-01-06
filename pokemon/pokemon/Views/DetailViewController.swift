//
//  DetailViewController.swift
//  pokemon
//
//  Created by 반성준 on 12/31/24.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {
    private let pokemon: Models.Pokemon
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    init(pokemon: Models.Pokemon) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure()
    }
    
    private func setupUI() {
        view.backgroundColor = .cellBackground
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    private func configure() {
        nameLabel.text = PokemonTranslator.getKoreanName(for: pokemon.name)
        
        // Extract Pokémon ID from URL
        if let id = pokemon.url.split(separator: "/").last,
           let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png") {
            imageView.kf.setImage(with: url)
        }
    }
}
