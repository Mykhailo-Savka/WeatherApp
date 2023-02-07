//
//  LocationServices.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 31.01.2023.
//
import MapKit
import CoreLocation

// MARK: - LocationServiceDelegate
protocol LocationServiceDelegate {
    func updateCity(city: City)
}

// MARK: - LocationServices
final class LocationServices: NSObject {
    
    // MARK: - Public Properties
    var delegate: LocationServiceDelegate?
    static let shared = LocationServices()
    var currentLocation: CLLocation? {
        return locationManager.location
    }
    
    // MARK: - Private Properties
    private let locationManager = CLLocationManager()
    private var latitude: Double = 0
    private var longitude: Double = 0
    
    // MARK: - Private Initialization
    private override init() {
        super.init()
        locationManager.delegate = self
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            setupLocationManager()
        default:
            latitude = 47.8388000
            longitude = 35.1395670
        }
    }
    
    // MARK: - Public methods
    func getPlace(for cityLocation: CLLocation,
                  completion: @escaping (_ city: City?) -> Void) {
        let locale = Locale(identifier: "uk-UA")
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(cityLocation, preferredLocale: locale) { placemarks, error in
            guard error == nil else {
                completion(nil)
                return
            }
            guard let placemark = placemarks?[0],
                  let cityName = placemark.locality else {
                completion(nil)
                return
            }
            var city = City()
            city.city = cityName
            city.latitude = cityLocation.coordinate.latitude
            city.longitude = cityLocation.coordinate.longitude

            completion(city)
        }
    }
    
    private func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationServices: CLLocationManagerDelegate {
    
    // MARK: - Method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        guard latitude != locationValue.latitude
                && longitude != locationValue.longitude else {
            return
        }
        latitude = locationValue.latitude
        longitude = locationValue.longitude
        
        let location = CLLocation(latitude: locationValue.latitude, longitude: locationValue.longitude)
        
        getPlace(for: location) { locationCity in
            guard let city = locationCity else { return }
            self.delegate?.updateCity(city: city)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            setupLocationManager()
        default:
            let location = CLLocation(latitude: 47.8388000, longitude: 35.1395670)
            
            getPlace(for: location) { locationCity in
                guard let city = locationCity else { return }
                self.delegate?.updateCity(city: city)
            }
        }
    }
}
