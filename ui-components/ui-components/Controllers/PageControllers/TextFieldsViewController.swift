//
//  TextFieldsViewController.swift
//  ui-components
//
//  Created by Jorge Benavides on 01/11/21.
//

import UIKit

class TextFieldsViewController: UIViewController, UserModelHandler {
    
    var userModel: User?
    
    @IBOutlet weak var nameLabel: UILabel?
    
    @IBOutlet weak var firstName: UITextField?
    
    @IBOutlet weak var lastName: UITextField?
    
    func updateUserModel() {
        userModel?.firstName = firstName?.text
        userModel?.lastName = lastName?.text
    }
    
    func updateNameLabel() {
        nameLabel?.text = userModel?.fullName
    }
}

extension  TextFieldsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateUserModel()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateUserModel()
        updateNameLabel()
    }
    
}
