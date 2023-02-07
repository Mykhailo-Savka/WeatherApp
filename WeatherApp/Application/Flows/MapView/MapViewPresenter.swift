//
//  MapViewPresenter.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 04.02.2023.
//

import Foundation
import CoreLocation

// MARK: - MapViewPresenterProtocol
protocol MapViewPresenterProtocol: AnyObject {
    var initialLocation: CLLocation? { get }
    
    func viewLoaded()
    func picked(location: CLLocation)
}

// MARK: - MapViewPresenter
final class MapViewPresenter {
    
    // MARK: - Public properties
    weak var view: MapViewControllerProtocol?
    var callBack: ((City) -> Void)?
    var initialLocation: CLLocation? {
        return locationService.currentLocation
    }
    
    // MARK: - Private properties
    private let locationService = LocationServices.shared
    
    // MARK: - Lifecycle
    init(view: MapViewControllerProtocol) {
        self.view = view
    }
}

// MARK: - MapViewPresenterProtocol implementation
extension MapViewPresenter: MapViewPresenterProtocol {
    func viewLoaded() {
        view?.setupUI()
    }
    
    func picked(location: CLLocation) {
        locationService.getPlace(for: location) { [weak self] city in
            guard let city else { return }
            self?.callBack?(city)
            self?.view?.popViewController()
        }
    }
}
