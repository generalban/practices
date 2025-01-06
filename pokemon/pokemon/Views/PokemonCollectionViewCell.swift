//
//  PokemonCollectionViewCell.swift
//  pokemon
//
//  Created by 반성준 on 12/31/24.
//

import UIKit
import Kingfisher

final class PokemonCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .cellBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        imageView.contentMode = .scaleAspectFit
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func configure(with pokemon: Models.Pokemon) {
        nameLabel.text = PokemonTranslator.getKoreanName(for: pokemon.name)
        if let id = pokemon.url.split(separator: "/").last,
           let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png") {
            imageView.kf.setImage(with: url)
        }
    }
}
