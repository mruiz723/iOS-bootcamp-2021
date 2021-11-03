//
//  UsersViewController.swift
//  dependency-injection
//
//  Created by Marlon David Ruiz Arroyave on 3/11/21.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var databaseService: DatabaseServiceProtocol?
    var users: [User]?
    var selectedUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Users"

        // Do any additional setup after loading the view.
        guard let databaseService = databaseService else {
            return
        }

        users = databaseService.getUsers()
        tableView.reloadData()

        print("The items are: \(databaseService.getUsers())")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailUser" {
            guard let userDetailVC = segue.destination as? DetailUserViewController, let user = sender as? User else {
                return
            }

            userDetailVC.user = user
        }
    }


    @IBSegueAction
    func makeDetailUserController(_ coder: NSCoder) -> DetailUserSegueActionViewController? {
        if let user = selectedUser {
            return DetailUserSegueActionViewController(user: user, coder: coder)
        } else {
            fatalError("A selecte user is required")
        }
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        cell.textLabel?.text = user?.name
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = users?[indexPath.row]
        guard let user = selectedUser else { return }

        // Constructor/Initalizer Injection
//        let detailUserVC = DetailUserProgrammaticallyViewController(user: user)
//        navigationController?.pushViewController(detailUserVC, animated: true)

        // Constructor/Initalizer Injection
//                performSegue(withIdentifier: "detailUserSegueAction", sender: user)

        // Property Injection
                performSegue(withIdentifier: "detailUser", sender: user)
    }
}
