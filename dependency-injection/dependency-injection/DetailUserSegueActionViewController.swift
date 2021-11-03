//
//  DetailUserSegueActionViewController.swift
//  dependency-injection
//
//  Created by Marlon David Ruiz Arroyave on 3/11/21.
//

import UIKit

class DetailUserSegueActionViewController: UIViewController {

    @IBOutlet private weak var userLabel: UILabel!
    private let user: User

    init?(user: User, coder: NSCoder) {
        self.user = user
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) is not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "User"
        userLabel.text = user.name
    }
}
