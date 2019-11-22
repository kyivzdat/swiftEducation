//
//  ViewController.swift
//  Fixing Interface Elements
//
//  Created by Vladyslav PALAMARCHUK on 11/22/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var celciusLabel: UILabel!
    @IBOutlet weak var fahrenheitLabel: UILabel!
    @IBOutlet weak var slider: UISlider! {
        didSet {
            slider.maximumValue = 233
            slider.minimumValue = -268
            slider.value = 0
        }
    }
    
    @IBAction func dragSlider(sender: UISlider) {
        let celciusT = String(Int(round(sender.value)))
        celciusLabel.text = celciusT + "ºC"
        let fahrenheitT = String(Int(round((sender.value * 9 / 5) + 32)))
        fahrenheitLabel.text = fahrenheitT + "ºF"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let topColor = UIColor.blue.cgColor
//        let botColor = UIColor.green.cgColor
//
//        let gradient = CAGradientLayer()
//        gradient.colors = [topColor, botColor]
////        gradient.locations = [0.0, 1.1]
//        gradient.startPoint = CGPoint(x: 0, y: 1)
//        gradient.endPoint = CGPoint(x: 1, y: 0)
//
//        gradient.frame = view.frame
//        view.layer.insertSublayer(gradient, at: 0)
        
    }


}

