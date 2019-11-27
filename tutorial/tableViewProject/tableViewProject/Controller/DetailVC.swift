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
    @IBOutlet weak var rateButton: UIButton!
    var restaurant: Restaurant?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "star")
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        rateButton.setImage(tintedImage, for: .normal)
        rateButton.tintColor = .yellow
//        rateButton.layer.cornerRadius = 5
//        rateButton.layer.borderWidth = 1
//        rateButton.layer.borderColor = UIColor.yellow.cgColor
        
        imageView.image = UIImage(named: restaurant?.image ?? "")

        tableView.tableFooterView = UIView(frame: CGRect.zero)
        title = restaurant?.name ?? ""
    }
    
    @IBAction func unwindToDetail(_ unwindSegue: UIStoryboardSegue) {
        guard let svc = unwindSegue.source as? RateVC else { return }
        guard let rating = svc.rate else { return }
        rateButton.setImage(UIImage(named: rating), for: .normal)
        // Use data from the view controller which initiated the unwind segue
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapVC" {
            let dvc = segue.destination as! MapVC
            dvc.restaurant = restaurant
        }
    }

}
