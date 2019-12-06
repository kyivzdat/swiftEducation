//
//  ViewController.swift
//  TodoList
//
//  Created by Vladyslav PALAMARCHUK on 12/6/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit
import CoreData

class MainListTVC: UITableViewController {

    var todoArray: [Task] = []
    lazy var context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    func fetchData() {
        guard let context = context else { return }
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            todoArray = []
            todoArray = try context.fetch(fetchRequest)
            print("Success fetch data!")
        } catch {
            print("Fail to fetch data! ", error)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let task = todoArray[indexPath.row]
        cell?.textLabel?.text = task.nameOfTask
        return cell!
    }
    
    @IBAction func clickAddButton(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Add new task", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
            let text = ac.textFields?[0].text
            self.saveData(taskToDo: text!)
//            self.todoArray.insert(text!, at: 0)
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addTextField(configurationHandler: nil)
        ac.addAction(cancel)
        ac.addAction(ok)
        present(ac, animated: true)
    }
    
    func saveData(taskToDo nameOfTask: String) {
        
        guard let context = context else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        let taskObject = NSManagedObject(entity: entity, insertInto: context) as! Task
        taskObject.nameOfTask = nameOfTask
        do {
            try context.save()
            todoArray.append(taskObject)
//            todoArray.insert(taskObject, at: 0)
            tableView.reloadData()
            print("Success save!")
        } catch {
            print("Fail to save! ", error)
        }
    }
}

