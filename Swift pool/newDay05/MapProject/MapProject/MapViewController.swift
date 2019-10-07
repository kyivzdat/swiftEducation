//
//  MapViewController.swift
//  MapProject
//
//  Created by Vladyslav PALAMARCHUK on 10/7/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate  {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segControl: UISegmentedControl!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualSetupSegControl()
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLoactionEnabled()
        checkAuthorizationStatus()
    }

    func checkLoactionEnabled() {
        if CLLocationManager.locationServicesEnabled() == true {

            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
    
        } else {
            
            showAllert(title: "Location service is off", message: "Do you want to enable?", url: URL(string: "App-Prefs:reool=LOCATION_SERVICES"))
        }
    }
    
//    func setupManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }

    func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways:
                break
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
                locationManager.startUpdatingLocation()
                break
            case .denied:
                showAllert(title: "Location disabled", message: "Do you want enable?", url: URL(string: UIApplication.openSettingsURLString))
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                break
            case .restricted:
                break
        }
      }

    func showAllert(title: String, message: String?, url: URL?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            if let url = URL(string: "App-Prefs:reool=LOCATION_SERVICES") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    func visualSetupSegControl() {
        self.segControl.layer.cornerRadius = 5;
        self.segControl.layer.borderColor = UIColor.black.cgColor;
        self.segControl.layer.borderWidth = 2;
        let font = UIFont.systemFont(ofSize: 17.5)
        self.segControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    }
    
    @IBAction func segControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 2:
            mapView.mapType = .satellite
        case 1:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    }
}

extension MapViewController:  CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorizationStatus()
    }
}
