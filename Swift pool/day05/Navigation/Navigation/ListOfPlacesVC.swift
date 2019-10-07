//
//  ListOfPlacesVC.swift
//  Navigation
//
//  Created by Vladyslav PALAMARCHUK on 10/6/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class ListOfPlacesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Array = \(arrayOfLocation.count)")
        return arrayOfLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationCell
        
        print(indexPath.row)
        cell.locationLabel.text = arrayOfLocation[indexPath.row]
        
        return cell
    }

}
