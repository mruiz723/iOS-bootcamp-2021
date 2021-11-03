//: [Previous](@previous)

import UIKit
import PlaygroundSupport

struct User {
    let id: Int
    let name: String
}

protocol DatabaseServiceProtocol {
  func getUsers() -> [User]
}

class CoreDataService: DatabaseServiceProtocol {
    func getUsers() -> [User] {
        return [
            User(id: 1, name: "Juan"),
            User(id: 1, name: "Michael"),
            User(id: 1, name: "Nicole"),
            User(id: 1, name: "Cristiano"),
            User(id: 1, name: "Lucas")
        ]
    }
}

class RealmService: DatabaseServiceProtocol {
    func getUsers() -> [User] {
        return [
            User(id: 1, name: "Maria"),
            User(id: 1, name: "Munich"),
            User(id: 1, name: "Nicole"),
            User(id: 1, name: "Julia"),
            User(id: 1, name: "Lucy")
        ]
    }
}

class UsersViewController : UIViewController {

    lazy var namesLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 23)
        label.numberOfLines = 0
        return label
    }()

    lazy var usersFromRealmButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Users from Realm", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(usersFromRealm), for: .touchUpInside)
        return button
    }()

    lazy var usersFromCoreDataButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Users from Core Data", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(usersFromCoreData), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView(arrangedSubviews: [namesLabel, usersFromRealmButton, usersFromCoreDataButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            usersFromCoreDataButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    }

    @objc
    private func addUserTapped() {
        print("Add new user")
    }

    @objc
    private func usersFromRealm() {
        let realmService = RealmService()
        namesLabel.text = getUsers(from: realmService)
    }

    @objc
    private func usersFromCoreData() {
        let coreDataService = CoreDataService()
        namesLabel.text = getUsers(from: coreDataService)
    }

    private func getUsers(from databaseService: DatabaseServiceProtocol) -> String {
        return databaseService.getUsers().map { $0.name }.joined(separator: ", ")
    }
}

let databaseService: DatabaseServiceProtocol = CoreDataService()
let usersVC: UsersViewController = UsersViewController()
let navigationController: UINavigationController = UINavigationController(rootViewController: usersVC)

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = navigationController.view

//: [Next](@next)
