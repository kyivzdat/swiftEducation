//
//  NewRestaurantTVC.swift
//  tableViewProject
//
//  Created by Vladyslav PALAMARCHUK on 11/27/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit
import CoreData

class NewRestaurantTVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var isVisitedSC: UISegmentedControl!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeDislikeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    
    var rating: String?
    
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
            if rating != nil {
                if let ratingImage = UIImage(named: rating!) {
                    restaurant.rating = ratingImage.pngData()
                }
            }
            do {
                try context.save()
                print("Success save new restaurant! 👍")
            } catch let error as NSError {
                print("Fail to save data of new restaurant! 👎\n\(error)\n", error.userInfo)
            }
        }
        performSegue(withIdentifier: "saveNewRestaurantSegue", sender: nil)
    }
    
    @IBAction func clickRateButton(sender: UIButton) {
    
        var sizeButtonArray: [[CGFloat]] = Array(repeatElement([1, 1], count: 3))
        let buttonArray = [dislikeButton, likeDislikeButton, likeButton]

        switch sender.tag {
        case 0:
            sizeButtonArray[2] = [1, 1]
            sizeButtonArray[1] = [1, 1]
    
            if rating == "dislike" {
                sizeButtonArray[0] = [1, 1]
                rating = nil
            } else {
                rating = "dislike"
                sizeButtonArray[0] = [1.3, 1.3]
            }
        case 1:
            sizeButtonArray[2] = [1, 1]
            sizeButtonArray[0] = [1, 1]

            if rating == "like_dislike" {
                rating = nil
                sizeButtonArray[1] = [1, 1]
            } else {
                rating = "like_dislike"
                sizeButtonArray[1] = [1.3, 1.3]
            }
        case 2:
            sizeButtonArray[1] = [1, 1]
            sizeButtonArray[0] = [1, 1]

            if rating == "like" {
                rating = nil
                sizeButtonArray[2] = [1, 1]
            } else {
                rating = "like"
                sizeButtonArray[2] = [1.3, 1.3]
            }
        default:
            break
        }
        
        for (index, button) in buttonArray.enumerated() {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                let x = sizeButtonArray[index][0]
                let y = sizeButtonArray[index][1]
                button?.transform = CGAffineTransform(scaleX: x, y: y)
            })
        }
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
