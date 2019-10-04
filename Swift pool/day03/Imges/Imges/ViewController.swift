//
//  ViewController.swift
//  Imges
//
//  Created by Vladyslav PALAMARCHUK on 10/4/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

var arr : [URL] = [URL(string: "https://images.wallpaperscraft.com/image/silhouette_coast_dark_148711_3840x2160.jpg")!,
                     URL(string: "https://images.wallpaperscraft.com/image/silhouette_sea_coast_136705_3840x2160.jpg")!,
                     URL(string: "https://www.wallpaperup.com/uploads/wallpapers/2014/10/21/489485/b807c2282ab0a491bd5c5c1051c6d312-1000.jpg")!, URL(string: "https://images.unsplash.com/photo-1534142499731-a32a99935397?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234")!, URL(string: "https://images.unsplash.com/photo-1531306728370-e2ebd9d7bb99?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234")!, URL(string: "https://images.unsplash.com/photo-1522827130596-971a53beeadc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234")!, URL(string: "https://images.unsplash.com/photo-1496361060943-f0ae4e7228f4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234")!, URL(string: "https://iages.unsplash.com/photo-1515395951575-a183b8cdfd3a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234")!]

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cel", for: indexPath) as! CollectionCell
        
        let session = URLSession.shared
        
        session.dataTask(with: arr[indexPath.row]) { (data, response, error) in
            if let data = data, let image = UIImage(data: data)
            {
                DispatchQueue.main.async {
                    cell.imageView.image = image
                    cell.loadView.stopAnimating()
                }
            }
            else
            {
                let act = UIAlertController(title: "Error", message: "Bad URL address", preferredStyle: .alert)
                act.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                cell.loadView.isHidden = true
                self.present(act, animated: true)

            }
        }.resume()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let seague = segue.destination as! ScrollView
        let cell = sender! as! CollectionCell
        if cell.imageView.image != nil {
            seague.image = cell.imageView.image!
        } else {
            let act = UIAlertController(title: "Error", message: "Can't open this image", preferredStyle: .alert)
            act.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(act, animated: true)
        }
    }

}
