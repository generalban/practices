//
//  PokemonCollectionViewCell.swift
//  pokemon
//
//  Created by 반성준 on 12/31/24.
//

import UIKit
import Kingfisher

class PokemonCollectionViewCell: UICollectionViewCell {
    static let identifier = "PokemonCell" // 셀 식별자 상수화
    
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
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true

        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
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
        nameLabel.text = pokemon.name.capitalized
        if let id = pokemon.url.split(separator: "/").last, let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png") {
            imageView.kf.setImage(with: url)
        }
    }
}
