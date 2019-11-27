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
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row != 0 {
            return nil
        }
        return indexPath
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
}
