//
//  PhoneBookViewController.swift
//  PokemonContacts
//
//  Created by 반성준 on 12/9/24.
//

import UIKit

class PhoneBookViewController: UIViewController {
    private var contact: Contact?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.gray.cgColor
        return imageView
    }()

    private let randomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let phoneField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "전화번호"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    init(contact: Contact?) {
        self.contact = contact
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if let contact = contact {
            loadContactData(contact)
        }
    }

    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = contact == nil ? "연락처 추가" : contact?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .done, target: self, action: #selector(saveContact))

        view.addSubview(imageView)
        view.addSubview(randomButton)
        view.addSubview(nameField)
        view.addSubview(phoneField)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),

            randomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),

            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameField.topAnchor.constraint(equalTo: randomButton.bottomAnchor, constant: 20),
            nameField.heightAnchor.constraint(equalToConstant: 40),

            phoneField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10),
            phoneField.heightAnchor.constraint(equalToConstant: 40)
        ])

        randomButton.addTarget(self, action: #selector(fetchRandomImage), for: .touchUpInside)
    }

    private func loadContactData(_ contact: Contact) {
        nameField.text = contact.name ?? "이름 없음" // Optional 처리
        phoneField.text = contact.phoneNumber ?? "번호 없음" // Optional 처리

        guard let profileImageURL = contact.profileImageURL,
              let imageData = Data(base64Encoded: profileImageURL),
              let image = UIImage(data: imageData) else {
            imageView.image = UIImage(systemName: "person.crop.circle") // 기본 이미지
            return
        }

        imageView.image = image
    }

    @objc private func fetchRandomImage() {
        PokemonAPIManager.shared.fetchRandomPokemonImage { [weak self] imageURL in
            guard let self = self, let imageURL = imageURL else { return }
            DispatchQueue.global(qos: .background).async {
                if let url = URL(string: imageURL), let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }

    @objc private func saveContact() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }

        let contact = self.contact ?? Contact(context: context) // 새 연락처 또는 기존 연락처 업데이트
        contact.name = nameField.text ?? ""
        contact.phoneNumber = phoneField.text ?? ""

        // 이미지를 Base64 문자열로 저장
        if let image = imageView.image, let imageData = image.pngData() {
            contact.profileImageURL = imageData.base64EncodedString()
        } else {
            contact.profileImageURL = "" // 기본값
        }

        // Core Data 저장
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Failed to save contact: \(error)")
            showAlert(title: "오류", message: "연락처 저장에 실패했습니다.")
        }
    }
}
