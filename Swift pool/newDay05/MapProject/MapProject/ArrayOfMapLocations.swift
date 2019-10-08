//
//  ArrayOfMapLocations.swift
//  MapProject
//
//  Created by Vladyslav PALAMARCHUK on 10/7/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import Foundation
import MapKit

struct mapLocationsStruct {
    let title: String
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    let color: UIColor
}

var mapLocations: [mapLocationsStruct] = [
    mapLocationsStruct(title: "Ecole 42", locationName: "96 Boulevard Beissiéres, 75017, Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8965523, longitude: 2.3162668), color: .yellow),
    mapLocationsStruct(title: "Apple", locationName: "Sacramento", coordinate: CLLocationCoordinate2D(latitude: 37.33182, longitude: -122.0333687), color: .green),
    mapLocationsStruct(title: "Himalaya", locationName: "Himalaya mountain", coordinate: CLLocationCoordinate2D(latitude: 30.0762021, longitude: 76.5791213), color: .red),
    mapLocationsStruct(title: "Unit Factory", locationName: "3 Dorogozhitska Street, Kyiv", coordinate: CLLocationCoordinate2D(latitude: 50.4688257, longitude: 30.4599701), color: .cyan)]
