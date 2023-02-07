//
//  MKMapView+CenterToLocation.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 04.02.2023.
//

import Foundation
import MapKit

extension MKMapView {
    func centerToLocation(_ location: CLLocation,
                          regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
            setRegion(coordinateRegion, animated: true)
    }
}
