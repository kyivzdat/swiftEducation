//
//  ViewController.swift
//  ex
//
//  Created by Vladyslav PALAMARCHUK on 10/1/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var resultLabel: UILabel!
    var button : Int = 0
    var result : Int = 0
    var oper : Character = "q"
    var refreshLabel : Bool = false
    var isResult = false
    
    @IBAction func acButton(_ sender: UIButton) {
        button = 0
        result = 0
        oper = "q"
        refreshLabel = false
        resultLabel.text = nil
    }

    func makePreOperation(_ result: Int, _ button: Int, _ oper: Character) -> (Int, Bool) {
        print("func makePreOperation: \(result) \(oper) \(button)")
        if oper == "q" {
            return (result, false)
        } else if oper == "+" {
            let res = result + button
            if res > INT_MAX {
                return (Int(INT_MAX), false)
            }
            return (res, false)
        } else if oper == "-" {
            let res = result - button
            if res < -2147483647 {
                return (-2147483647, false)
            }
            return (res, false)
        } else if oper == "*" {
            let res = result * button
            if res > INT_MAX {
                return (Int(INT_MAX), false)
            }
            return (res, false)
        } else if oper == "/" {
            if button == 0 {
                return (result, true)
            }
            let res = result / button
            if res < -2147483647 {
                return (-2147483647, false)
            }
            return (res, false)
        } else if oper == "%" {
            if button == 0 {
                return (0, false)
            }
            let res = result % button
            if res > INT_MAX {
                return (Int(INT_MAX), false)
            }
            return (res, false)
        }
        return (result, false)
    }

    @IBAction func oneButton(_ sender: UIButton) {
        if refreshLabel == true || (result > 0 && button == 0) {
            resultLabel.text = nil
            button = 0
            refreshLabel = false
        }
        if resultLabel.text != nil {
            if Int(resultLabel.text!) == 0 {
                resultLabel.text = String(sender.tag)
            } else {
                if button * 10 + sender.tag > Int(INT_MAX) {
                    resultLabel.text = String(INT_MAX)
                    button = Int(INT_MAX)
                    return
                }
                resultLabel.text =  resultLabel.text! + String(sender.tag)
            }
        } else {
            resultLabel.text = String(sender.tag)
        }
        button = button * 10 + sender.tag
        isResult = false
    }
    

    
    @IBAction func plusButton(_ sender: UIButton) {
        print("func plusButton: \(result) \(oper) \(button)")
        oper = "+"
        if isResult == false {
            let a : (Int, Bool) = makePreOperation(result, button , oper)
            if a.1 == true {
                resultLabel.text = "Error"
            } else {
                result = a.0
            }
        }
        button = 0
        refreshLabel = true
    }
    

    @IBAction func negButton(_ sender: UIButton) {
        if isResult == true {
            result *= -1
            resultLabel.text = String(result)
        } else {
            if resultLabel != nil {
                button *= -1
                resultLabel.text = String(button)
            }
        }
    }

    @IBAction func minusButton(_ sender: UIButton) {
        print("func minusButton: \(result) \(oper) \(button)")
        oper = "-"
        if isResult == false {
            if result == 0 {
                result = button
            } else {
                let a : (Int, Bool) = makePreOperation(result, button , oper)
                if a.1 == true {
                    resultLabel.text = "Error"
                } else {
                    result = a.0
                }
            }
        }
        button = 0
        refreshLabel = true
    }

    @IBAction func multButton(_ sender: UIButton) {
        print("func multButton: \(result) \(oper) \(button)")
        oper = "*"
        if isResult == false {
            if result == 0 {
                result = button
            } else {
                let a : (Int, Bool) = makePreOperation(result, button , oper)
                if a.1 == true {
                    resultLabel.text = "Error"
                } else {
                    result = a.0
                }
            }
        }
        button = 0
        refreshLabel = true
    }
    
    @IBAction func modButton(_ sender: UIButton) {
        print("func modButton: \(result) \(oper) \(button)")
        oper = "%"
        if isResult == false {
            if result == 0 {
                result = button
            } else {
                let a : (Int, Bool) = makePreOperation(result, button , oper)
                if a.1 == true {
                    resultLabel.text = "Error"
                } else {
                    result = a.0
                }
            }
        }
        button = 0
        refreshLabel = true
    }
    
    @IBAction func divisionButton(_ sender: UIButton) {
        print("func divisionButton: \(result) \(oper) \(button)")
        oper = "/"
        if isResult == false {
            if result == 0 {
                result = button
            } else {
                let a : (Int, Bool) = makePreOperation(result, button , oper)
                if a.1 == true {
                    resultLabel.text = "Error"
                } else {
                    result = a.0
                }
            }
        }
        button = 0
        refreshLabel = true
    }

    @IBAction func resultButton(_ sender: UIButton) {
        print("func resultButton: \(result) \(oper) \(button)")
        let a : (Int, Bool) = makePreOperation(result, button , oper)
        if a.1 == true {
            resultLabel.text = "Error"
            result = 0
        } else {
            result = a.0
            resultLabel.text = String(result)
            isResult = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

