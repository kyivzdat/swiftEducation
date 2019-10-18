//
//  MapViewController.swift
//  MapProject
//
//  Created by Vladyslav PALAMARCHUK on 10/7/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var naviButton: UIButton!
    
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        visualSetupSegControl()
        mapView.delegate = self
        configureLocationServices()
        
        for locations in mapLocations {
            let pin = MKPointAnnotation()
            pin.coordinate = locations.coordinate
            pin.title = locations.title
            pin.subtitle = locations.locationName
            mapView.addAnnotation(pin)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var color = UIColor.white;
        print("add color")
        for dataPoints in mapLocations {
            if (dataPoints.coordinate.latitude == annotation.coordinate.latitude && dataPoints.coordinate.longitude == annotation.coordinate.longitude) {
                color = dataPoints.color;
            }
        }
        if (color == UIColor.white) {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "MyLocation") as? MKPinAnnotationView;
            annotationView?.annotation = annotation;
            return (annotationView);
        }
        var view: MKPinAnnotationView;
        view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin");
        view.canShowCallout = true;
        view.calloutOffset = CGPoint(x: -9, y: 9);
        view.pinTintColor = color;
        return (view);
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
        checkAuthorizationStatus()
    }
    
    func configureLocationServices() {
    
        locationManager.delegate = self
    
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: locationManager)
        }
    }
    
    @IBAction func naviButton(_ sender: UIButton) {
        zoomToLatestLocation(with: CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!))
    }
    
    func beginLocationUpdates(locationManager: CLLocationManager) {
        
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(zoomRegion, animated: true)
    }

    func checkLocationEnabled() {

        if CLLocationManager.locationServicesEnabled() == false {
            showAllert(title: "Location service is off", message: "Do you want to enable?", url: URL(string: "App-Prefs:reool=LOCATION_SERVICES"))
        }
    }

    func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
            case .denied:
                showAllert(title: "Location disabled", message: "Do you want enable?", url: URL(string: UIApplication.openSettingsURLString))
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                beginLocationUpdates(locationManager: locationManager)
            default:
                break ;
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
        
        print("Did get latest location")
        
        let latestLocation = mapLocations[0]
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
        }
        currentCoordinate = latestLocation.coordinate

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("The status changed")
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: manager)
        }
    }
}
