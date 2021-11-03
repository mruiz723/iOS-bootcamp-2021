//
//  DetailUserViewController.swift
//  dependency-injection
//
//  Created by Marlon David Ruiz Arroyave on 3/11/21.
//

import UIKit

class DetailUserViewController: UIViewController {

    @IBOutlet private weak var userLabel: UILabel!
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "User"

        guard let user = user else {
            return
        }

        userLabel.text = user.name
    }
}
