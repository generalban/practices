//
//  MainViewController.swift
//  PokemonContacts
//
//  Created by 반성준 on 12/9/24.
//

import UIKit

class MainViewController: UIViewController {
    private var contacts: [Contact] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData() // 데이터를 갱신하여 테이블 뷰를 업데이트
    }

    private func setupUI() {
        title = "친구 목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContact))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.rowHeight = 80
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }

    private func fetchData() {
        contacts = DataManager.shared.fetchAllContacts()
        tableView.reloadData() // 데이터를 다시 로드
    }

    @objc private func addContact() {
        let addVC = PhoneBookViewController(contact: nil)
        navigationController?.pushViewController(addVC, animated: true)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactTableViewCell
        cell.configure(with: contacts[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        let editVC = PhoneBookViewController(contact: contact)
        navigationController?.pushViewController(editVC, animated: true)
    }
}
