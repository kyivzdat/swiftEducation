//
//  ViewController.swift
//  MapProject
//
//  Created by Vladyslav PALAMARCHUK on 10/7/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit
import MapKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MapLocationTableViewCell
        
        cell.mapLocationLabel.text = mapLocations[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let test = self.tabBarController?.viewControllers![0] as! MapViewController
        test.zoomToLatestLocation(with: mapLocations[indexPath.row].coordinate)
        self.tabBarController?.selectedViewController = test
    }
}
