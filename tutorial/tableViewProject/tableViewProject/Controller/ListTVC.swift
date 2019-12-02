//
//  ListTVC.swift
//  tableViewProject
//
//  Created by Vladyslav PALAMARCHUK on 11/25/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit
import CoreData

class ListTVC: UITableViewController, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate {

    var fetchResultsController: NSFetchedResultsController<Restaurant>!
    
    var searchController: UISearchController!

    var filteredRestaurants: [Restaurant] = []
    var restaurants: [Restaurant] = []
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.delegate = self
        setupSearchController()
        initRestaurantsFromDB()
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        //        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    
    func initRestaurantsFromDB() {
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            do {
                try fetchResultsController.performFetch()
                restaurants = fetchResultsController.fetchedObjects!
            } catch {
                print("Fail to fetch context! 👎", error)
            }
        }
    }
    
    //MARK: - Fetch core data
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {
        case .insert:
            guard let indexPath = newIndexPath else { break }
            tableView.insertRows(at: [indexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath else { break }
            tableView.deleteRows(at: [indexPath], with: .fade)

//            guard let indexPath = indexPath else { break }
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            var newIndexPath = indexPath
//            if self.searchController.searchBar.text != "" {
//                for (index, restaurant) in self.filteredRestaurants.enumerated() {
//                    if restaurant.name == self.restaurants[indexPath.row].name {
//                        guard let testIndexPath = self.fetchResultsController.indexPath(forObject: restaurant) else { return }
//                        newIndexPath = testIndexPath
//                        tableView.deleteRows(at: [newIndexPath], with: .fade)
//                        self.filteredRestaurants.remove(at: index)
//                        self.restaurants.remove(at: indexPath.row)
//                        break
//                    }
//                }
//            } else {
////                tableView.deleteRows(at: [newIndexPath], with: .fade)
//            }
        case .update:
            guard let indexPath = indexPath else { break }
            tableView.reloadRows(at: [indexPath], with: .fade)
        default:
            tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as! [Restaurant]
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func restaurantsToDisplayAt(indexPath: IndexPath) -> Restaurant {
        var restaurant: Restaurant
        
        if searchController.isActive && searchController.searchBar.text != "" {
            restaurant = filteredRestaurants[indexPath.row]
        } else {
            restaurant = restaurants[indexPath.row]
        }
        return restaurant
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredRestaurants.count
        }
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! Cell
        
        let restaurant = restaurantsToDisplayAt(indexPath: indexPath)
        cell.nameLabel.text = restaurant.name
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        cell.picture.image = UIImage(data: restaurant.image! as Data)
        cell.picture.layer.cornerRadius = 10
        cell.ratingImage.image = (restaurant.rating != nil) ? UIImage(data: restaurant.rating!) : nil
        cell.accessoryType = restaurant.isVisited ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "❌") { (action, indexPath) in
            
//            print("Delete")
//
//            var newIndexPath = indexPath
//            if self.searchController.isActive && self.searchController.searchBar.text != "" {
//                for (index, restaurant) in self.restaurants.enumerated() {
//                    if restaurant.name == self.filteredRestaurants[indexPath.row].name {
//
//                        guard let testIndexPath = self.fetchResultsController.indexPath(forObject: self.restaurants[index]) else { return }
//                        newIndexPath = testIndexPath
//
//                        self.filteredRestaurants.remove(at: indexPath.row)
//                        self.restaurants.remove(at: newIndexPath.row)
//                        break
//                    }
//                }
//            } else {
                self.restaurants.remove(at: indexPath.row)
//            }
        
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                
                let objectToDelete = self.fetchResultsController.object(at: indexPath)
//                newIndexPath = indexPath
                context.delete(objectToDelete)
                
                do {
                    
                    try context.save()
                    print("Delete row was success! 👍")
//                    if self.searchController.isActive && self.searchController.searchBar.text != "" {
//                        tableView.deleteRows(at: [indexPath], with: .fade)
//                    }
                } catch {
                    print ("Delete row was not success! 👎\n", error)
                }
            }
        }
        let share = UITableViewRowAction(style: .default, title: "✉️") { (action, indexPath) in
            let text = "Now, I'm in " + (self.restaurants[indexPath.row].name ?? "")
            if let image = UIImage(data: self.restaurants[indexPath.row].image! as Data) {
                let ac = UIActivityViewController(activityItems: [text, image], applicationActivities: nil)
                self.present(ac, animated: true)
            }
        }
        share.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.6117647059, blue: 1, alpha: 1)
        return [delete, share]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? DetailVC else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            dvc.restaurant = restaurantsToDisplayAt(indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func close(sender: UIStoryboardSegue) {
    }
    
    func filterContentFor(searchText text: String) {
        filteredRestaurants = restaurants.filter({ (restaurant) -> Bool in
            return (restaurant.name!.lowercased()).contains(text.lowercased())
        })
    }

}

extension ListTVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentFor(searchText: searchController.searchBar.text!)
        tableView.reloadData()
    }
}

