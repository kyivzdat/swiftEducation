//
//  ListTVC.swift
//  tableViewProject
//
//  Created by Vladyslav PALAMARCHUK on 11/25/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class ListTVC: UITableViewController {

    var restaurants: [Restaurant] = [
        Restaurant(name: "Ogonёk Grill&Bar", type: "ресторан", location: "Уфа", image: "ogonek.jpg", isVisited: false),
        Restaurant(name: "Елу", type: "ресторан", location: "Уфа", image: "elu.jpg", isVisited: false),
        Restaurant(name: "Bonsai", type: "ресторан", location: "Уфа", image: "bonsai.jpg", isVisited: false),
        Restaurant(name: "Дастархан", type: "ресторан", location: "Уфа", image: "dastarhan.jpg", isVisited: false),
        Restaurant(name: "Индокитай", type: "ресторан", location: "Уфа", image: "indokitay.jpg", isVisited: false),
        Restaurant(name: "X.O", type: "ресторан-клуб", location: "Уфа", image: "x.o.jpg", isVisited: false),
        Restaurant(name: "Балкан Гриль", type: "ресторан", location: "Уфа", image: "balkan.jpg", isVisited: false),
        Restaurant(name: "Respublica", type: "ресторан", location: "Уфа", image: "respublika.jpg", isVisited: false),
        Restaurant(name: "Speak Easy", type: "ресторанный комплекс", location: "Уфа", image: "speakeasy.jpg", isVisited: false),
        Restaurant(name: "Morris Pub", type: "ресторан", location: "Уфа", image: "morris.jpg", isVisited: false),
        Restaurant(name: "Вкусные истории", type: "ресторан", location: "Уфа", image: "istorii.jpg", isVisited: false),
        Restaurant(name: "Классик", type: "ресторан", location: "Уфа", image: "klassik.jpg", isVisited: false),
        Restaurant(name: "Love&Life", type: "ресторан", location: "Уфа", image: "love.jpg", isVisited: false),
        Restaurant(name: "Шок", type: "ресторан", location: "Уфа", image: "shok.jpg", isVisited: false),
        Restaurant(name: "Бочка", type: "ресторан", location:  "Уфа", image: "bochka.jpg", isVisited: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! Cell
        
        cell.nameLabel.text = restaurants[indexPath.row].name
        cell.locationLabel.text = restaurants[indexPath.row].location
        cell.typeLabel.text = restaurants[indexPath.row].type
        cell.picture.image = UIImage(named: restaurants[indexPath.row].image)
        cell.picture.layer.cornerRadius = 10
        cell.accessoryType = restaurants[indexPath.row].isVisited ? .checkmark : .none
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let ac = UIAlertController(title: nil, message: "Choose action", preferredStyle: .actionSheet)
//
//        let message = isVisited[indexPath.row] ? "I have not been here" : "I have been here"
//        let isVisitedAction = UIAlertAction(title: message, style: .default) { (action) in
//            self.isVisited[indexPath.row] = !self.isVisited[indexPath.row]
//            let cell = tableView.cellForRow(at: indexPath)
//            cell?.accessoryType = self.isVisited[indexPath.row] ? .checkmark : .none
//        }
//        let call = UIAlertAction(title: "+38(097)342-43-3\(indexPath.row)", style: .default) { (action) in
//            let alert = UIAlertController(title: "Ошибочка", message: "На даний момент абонент не може прийняти ваш дзвінок", preferredStyle: .alert)
//            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//            alert.addAction(action)
//            self.present(alert, animated: true)
//        }
//
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        ac.addAction(call)
//        ac.addAction(cancel)
//        ac.addAction(isVisitedAction)
//        present(ac, animated: true)
//    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            restaurantNames.remove(at: indexPath.row)
//            restaurantImages.remove(at: indexPath.row)
//            isVisited.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "❌") { (action, indexPath) in
            self.restaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let share = UITableViewRowAction(style: .default, title: "✉️") { (action, indexPath) in
            let text = "Now, I'm in " + self.restaurants[indexPath.row].name
            if let image = UIImage(named: self.restaurants[indexPath.row].image) {
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
            dvc.restaurant = restaurants[indexPath.row]
        }
    }

}
