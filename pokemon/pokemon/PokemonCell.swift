//
//  PokemonCollectionViewCell.swift
//  pokemon
//
//  Created by 반성준 on 1/3/25.
//

import UIKit
import Kingfisher

class PokemonListCell: UICollectionViewCell {
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
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 12)
    }

    func configure(with pokemon: Models.Pokemon) {
        nameLabel.text = PokemonTranslator.getKoreanName(for: pokemon.name)
        if let id = pokemon.url.split(separator: "/").last, let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png") {
            imageView.kf.setImage(with: url)
        }
    }
}
