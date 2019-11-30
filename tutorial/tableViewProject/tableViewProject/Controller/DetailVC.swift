//
//  DetailVC.swift
//  tableViewProject
//
//  Created by Vladyslav PALAMARCHUK on 11/25/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rateButton: UIButton!
    var restaurant: Restaurant!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var image: UIImage?
        if restaurant.rating != nil{
            image = UIImage(data: restaurant.rating! as Data)
        } else {
            image = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
            rateButton.tintColor = .yellow
        }
        rateButton.setImage(image, for: .normal)
        
        imageView.image = UIImage(data: restaurant.image! as Data)

        tableView.tableFooterView = UIView(frame: CGRect.zero)
        title = restaurant?.name ?? ""
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "MyRestaurants") as? ListTVC else { return }
            for i in 0..<vc.restaurants.count {
                if vc.restaurants[i].name == restaurant.name {
                    vc.restaurants[i] = restaurant
                    break
                }
            }
        }
    }
    
    @IBAction func unwindToDetail(_ unwindSegue: UIStoryboardSegue) {
        guard let svc = unwindSegue.source as? RateVC else { return }
        guard let rating = svc.rate else { return }
        let rateImage = UIImage(named: rating)
        if restaurant.image != nil {
            if UIImage(data: restaurant.image!) != rateImage {
                rateButton.setImage(rateImage, for: .normal)
                restaurant.rating = rateImage?.pngData()
                updateRatingInfo()
            }
        }
        // Use data from the view controller which initiated the unwind segue
    }
    
    func updateRatingInfo() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext else { return }
        let fetchRequest: NSFetchRequest<Restaurant> = NSFetchRequest.init(entityName: "Restaurant")
        fetchRequest.predicate = NSPredicate(format: "name = %@", restaurant.name!)
        do {
            let test = try context.fetch(fetchRequest)
            let objectUpdate = test[0] as NSManagedObject
            objectUpdate.setValue(restaurant.rating, forKey: "rating")
            do {
                try context.save()
                print("Success update! 👍")
            } catch {
                print("Failed update! 👎", error)
            }
        } catch {
            print("Failed request! 👎", error)
        }
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
