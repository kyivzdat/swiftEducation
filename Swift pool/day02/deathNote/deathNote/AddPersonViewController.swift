//
//  AddPersonViewController.swift
//  deathNote
//
//  Created by Vladyslav PALAMARCHUK on 10/3/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var dateDatePiecker: UIDatePicker!
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        if nameTextField.text != nil && nameTextField.text != "" {
            let format = DateFormatter()
            format.dateFormat = "dd.MM.yyyy HH:mm"
            let date  = format.string(from: dateDatePiecker.date)
            print("Got new person:\n\tname = \(String(nameTextField.text!))\n\tdate = \(date)\n\tdescription = \(String(descTextView.text!))")
            arr.append([nameTextField.text!, date, descTextView.text])
        } else {
            print("Error. Empty name")
        }
        let goTo = storyboard?.instantiateViewController(withIdentifier: "goBack") as? UINavigationController
        self.present(goTo!, animated: true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        descTextView.layer.borderWidth = 0.5
        descTextView.layer.borderColor = borderColor.cgColor
        descTextView.layer.cornerRadius = 5.0

    }

    
}
