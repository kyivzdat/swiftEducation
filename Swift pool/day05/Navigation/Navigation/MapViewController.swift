//
//  ViewController.swift
//  Navigation
//
//  Created by Vladyslav PALAMARCHUK on 10/6/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
//        map.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//        self.view.backgroundColor = .cyan

    }



//    @IBAction func segControl(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            mapView.mapType = .standard
//        case 1:
//            mapView.mapType = .hybrid
//        default:
//            mapView.mapType = .satelite
//        }
//    }
    

}
