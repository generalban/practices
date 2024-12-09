//
//  ContactTableViewCell.swift
//  PokemonContacts
//
//  Created by 반성준 on 12/9/24.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)

        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),

            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            phoneLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            phoneLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])

        // 프로필 이미지 뷰를 원형으로 설정
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.gray.cgColor

        // 원형 영역을 벗어나지 않도록 마스크 적용
        let circularPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 60, height: 60))
        let mask = CAShapeLayer()
        mask.path = circularPath.cgPath
        profileImageView.layer.mask = mask
    }

    func configure(with contact: Contact) {
        nameLabel.text = contact.name ?? "이름 없음"
        phoneLabel.text = contact.phoneNumber ?? "번호 없음"

        let profileImageURL = contact.profileImageURL ?? ""
        if let imageData = Data(base64Encoded: profileImageURL),
           let image = UIImage(data: imageData) {
            profileImageView.image = image
        } else {
            profileImageView.image = UIImage(systemName: "person.crop.circle") // 기본 이미지
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        // 셀 재사용 시 초기화
        profileImageView.image = nil
        nameLabel.text = nil
        phoneLabel.text = nil
    }
}
