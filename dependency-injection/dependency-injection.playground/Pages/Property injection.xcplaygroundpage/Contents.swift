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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var navigationBar: UINavigationBar = {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUserTapped))
        let navItem: UINavigationItem = UINavigationItem(title: "Users")

        // Property Injection
        navItem.rightBarButtonItem = rightBarButtonItem

        // Method injection
        navBar.pushItem(navItem, animated: false)
        return navBar
    }()

    var databaseService: DatabaseServiceProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        setupView()
        let users = databaseService?.getUsers().map { $0.name }.joined(separator: ", ")
        namesLabel.text = users
    }

    @objc
    private func addUserTapped() {
        print("Add new user")
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(namesLabel)
        view.addSubview(navigationBar)

        NSLayoutConstraint.activate([
            namesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            namesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// Property Injection
let databaseService: DatabaseServiceProtocol = CoreDataService()
let usersVC: UsersViewController = UsersViewController()
usersVC.databaseService = databaseService

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = usersVC

//: [Next](@next)
