//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 04.02.2023.
//

import UIKit
import MapKit

// MARK: - MapViewControllerProtocol
protocol MapViewControllerProtocol: AnyObject {
    func setupUI()
    func popViewController()
}

// MARK: - MapViewController
final class MapViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK: - Public properties
    var presenter: MapViewPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }
    
    // MARK: - @objc private method
    @objc private func triggerTouchAction(gestureRecognizer: UITapGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: mapView)
        let location = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        presenter.picked(location: CLLocation(latitude: location.latitude,
                                              longitude: location.longitude))
    }
    
    // MARK: - IBAction
    @IBAction private func onBackButton(_ sender: UIButton) {
        popViewController()
    }
}

// MARK: - MapViewControllerProtocol implementation
extension MapViewController: MapViewControllerProtocol {
    func setupUI() {
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(triggerTouchAction(gestureRecognizer:)))
        mapView.addGestureRecognizer(gestureRecognizer)
        guard let initialLocation = presenter.initialLocation else { return }
        mapView.centerToLocation(initialLocation)
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
