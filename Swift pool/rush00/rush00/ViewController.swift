//
//  ViewController.swift
//  rush00
//
//  Created by Vladyslav PALAMARCHUK on 10/5/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getButton(_ sender: UIButton) {
        guard let url = URL(string: "https://profile.intra.42.fr/") else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print("RESPONSE\n\n")
                print(response)
            }
            guard let data = data else { return }
            print("DATA\n\n")
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("JSON\n\n")
                print(json)
            } catch {
                print("ERROR\n\n")
                print(error)
            }
        }.resume()
    }
    
    @IBAction func postButton(_ sender: UIButton) {
    }
    
}

