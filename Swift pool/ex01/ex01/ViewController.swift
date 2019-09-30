//
//  ViewController.swift
//  ex01
//
//  Created by Vladyslav PALAMARCHUK on 9/30/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var number = 0
    @IBOutlet weak var label: UILabel!
    @IBAction func clickButton(_ sender: UIButton) {
        if (number == 100) {
            number = 0
        }
        number += 1
        label.text = "Hello World ! \(number)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

