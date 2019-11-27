//
//  MapVC.swift
//  tableViewProject
//
//  Created by Vladyslav PALAMARCHUK on 11/27/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setupPinOnMap()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil}
        
        let annotationIdentifier = "restaurantAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
     
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
            print(1)
        }
        
        let rightImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rightImage.image = UIImage(named: restaurant.image)
        annotationView?.rightCalloutAccessoryView = rightImage
        
        annotationView?.pinTintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)

        return annotationView
    }
    
    func setupPinOnMap() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(restaurant.location) { (placemarks, error) in
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = self.restaurant.name
            annotation.subtitle = self.restaurant.type
            
            guard let location = placemark?.location else { return }
            annotation.coordinate = location.coordinate
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }

}
