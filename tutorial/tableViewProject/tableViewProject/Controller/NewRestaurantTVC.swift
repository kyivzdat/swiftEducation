//
//  NewRestaurantTVC.swift
//  tableViewProject
//
//  Created by Vladyslav PALAMARCHUK on 11/27/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class NewRestaurantTVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var isVisitedSC: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickSaveButton(_ sender: UIBarButtonItem) {
        var emptyFieldArray = ""
        
        if nameField.text == "" {
            emptyFieldArray += "Name"
        }
        if addressField.text == "" {
            emptyFieldArray += emptyFieldArray.isEmpty ? "Address" : ", address"
        }
        if typeField.text == "" {
            emptyFieldArray += emptyFieldArray.isEmpty ? "Type" : ", type"
        }
        
        guard emptyFieldArray.isEmpty == true else {
            let alertTittle = emptyFieldArray.components(separatedBy: " ").count == 1 ? "Empty field" : "Empty fields"
            let ac = UIAlertController(title: alertTittle, message: emptyFieldArray, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            ac.addAction(okAction)
            present(ac, animated: true)
            return
        }
        
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            let restaurant = Restaurant(context: context)
            restaurant.name = nameField.text
            restaurant.type = typeField.text
            restaurant.location = addressField.text
            restaurant.isVisited = isVisitedSC!.selectedSegmentIndex == 0 ? false : true
            if let image = imageView.image {
                restaurant.image = image.pngData()
            }
            
            do {
                try context.save()
                print("Success save 👍")
            } catch let error as NSError {
                print("Fail to save data: \(error)\n", error.userInfo)
            }
        }
        performSegue(withIdentifier: "saveNewRestaurantSegue", sender: nil)
    }

    func chooseImagePickerAction(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        self.dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.view.endEditing(true)
        if indexPath.row == 0 {
            let ac = UIAlertController(title: "Choose source of photo", message: nil, preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Camera 📷", style: .default) { (action) in
                self.chooseImagePickerAction(source: .camera)
            }
            let libImageAction = UIAlertAction(title: "Photo 🖼", style: .default) { (action) in
                self.chooseImagePickerAction(source: .photoLibrary)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cameraAction)
            ac.addAction(libImageAction)
            ac.addAction(cancelAction)
            self.present(ac, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
