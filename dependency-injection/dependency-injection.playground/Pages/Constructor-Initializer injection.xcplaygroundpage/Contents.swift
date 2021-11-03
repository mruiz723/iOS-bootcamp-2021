//: A UIKit based Playground for presenting user interface
  
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

    private let databaseService: DatabaseServiceProtocol

    // Constructor/Initializer Injection
    init(databaseService: DatabaseServiceProtocol) {
        self.databaseService = databaseService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        setupView()
        let users = databaseService.getUsers().map { $0.name }.joined(separator: ", ")
        namesLabel.text = users
    }

    @objc
    private func addUserTapped() {
        print("Add new user")
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(namesLabel)
        NSLayoutConstraint.activate([
            namesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            namesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// Constructor/Initializer Injection
let databaseService: DatabaseServiceProtocol = CoreDataService()
let usersVC: UsersViewController = UsersViewController(databaseService: databaseService)

// Constructor/Initializer Injection
let navController: UINavigationController = UINavigationController(rootViewController: usersVC)

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = navController.view

//: [Next](@next)
