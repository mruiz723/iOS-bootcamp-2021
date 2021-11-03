//
//  DetailUserProgrammaticallyViewController.swift
//  dependency-injection
//
//  Created by Marlon David Ruiz Arroyave on 3/11/21.
//

import UIKit

class DetailUserProgrammaticallyViewController: UIViewController {

    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let user: User

    // Constructor/Initializer Injection
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        nameLabel.text = user.name

        // Property Injection
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUserTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc
    private func addUserTapped() {
        print("Add new user")
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
