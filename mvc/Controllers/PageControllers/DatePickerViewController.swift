//
//  DatePickerViewController.swift
//  mvc
//
//  Created by Jorge Benavides on 01/11/21.
//

import UIKit

class DatePickerViewController: UIViewController, UserModelHandler {
    
    var userModel: User?
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        dateLabel.text = sender.date.ISO8601Format()
    }
    
}
