//
//  ViewController.swift
//  deathNote
//
//  Created by Vladyslav PALAMARCHUK on 10/3/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

var arr : [[String]] = [["Brian Griffin", "24.10.2020 23:12", "An anthropomorphic white dog."],
                        ["Kenny McCormick", "12.04.2021 23:12", "Kenny McCormick is the poor member of the Four Boys."],
                        ["Sherry Bobbins", "02.12.2020 23:12", "Shary Bobbins proves to be a big help for the Simpson family, helping the kids clean their rooms and even helping to make Mr. Burns happy. "]]

import UIKit

class dataCell : UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       createTable()
    }
    
    func createTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
     
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "indetifire", for: indexPath) as! dataCell
        cell.nameLabel?.text = arr[indexPath.row][0]
        cell.dateLabel?.text = arr[indexPath.row][1]
        cell.descriptionLabel?.text = arr[indexPath.row][2]
        print("Print in table:\n\tname = \(String(cell.nameLabel.text!))\n\tdate = \(String(cell.dateLabel.text!))\n\tdescription = \(String(cell.descriptionLabel.text!))")
        
        return cell
    }
}
