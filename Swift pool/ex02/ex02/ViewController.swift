//
//  ViewController.swift
//  ex02
//
//  Created by Vladyslav PALAMARCHUK on 9/30/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var value : Int = 0
    var result : Int = 0
    var ch : Character = "1"
    @IBOutlet weak var resultLabel: UILabel!
    
    resultLabel.text = "0"

    @IBAction func acButton(_ sender: UIButton) {
        resultLabel.text = ""
        result = 0
        value = 0
    }

    func operation(val1: Int, val2: Int, ch: Character) -> Int {
        if ch == "+" {
            print("val1 = \(val1), val2 = \(val2)")
            return val1 + val2
        } else if ch == "-" {
            return val1 - val2
        }
        return 0
    }
    
    @IBAction func oneButton(_ sender: UIButton) {
        value = value * 10 + 1
        print("1 = \(value)")
        if resultLabel.text != nil {
            resultLabel.text = resultLabel.text! + "1"
        } else {
            resultLabel.text = "1"
        }
    }
    
    @IBAction func twoButton(_ sender: UIButton) {
        value = value * 10 + 2
        print("2 = \(value)")
        if resultLabel.text != nil {
            resultLabel.text = resultLabel.text! + "2"
        } else {
            resultLabel.text = "2"
        }
    }
    
    
    @IBAction func plusButton(_ sender: UIButton) {
        if resultLabel.text!.isEmpty == false {
            resultLabel.text = resultLabel.text! + " + "
        }
        result = value
        value = 0
        ch = "+"
    }
    @IBAction func resultButton(_ sender: UIButton) {
        print("result = \(result), value = \(value)")
        resultLabel.text = String(operation(val1: result, val2: value, ch: ch))
        result = 0
        value = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

