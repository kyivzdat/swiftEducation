//
//  DetailVC.swift
//  tableViewProject
//
//  Created by Vladyslav PALAMARCHUK on 11/25/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class DetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var restaurant: Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: restaurant?.image ?? "")
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as! DetailCell
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Name:"
            cell.valueLabel.text = restaurant!.name
        case 1:
            cell.keyLabel.text = "Type:"
            cell.valueLabel.text = restaurant!.type
        case 2:
            cell.keyLabel.text = "Address:"
            cell.valueLabel.text = restaurant!.location
        case 3:
            cell.keyLabel.text = "Have I been here?"
            cell.valueLabel.text = restaurant!.isVisited ? "Yes" : "No"
        default:
            break
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
