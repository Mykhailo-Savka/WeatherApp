//
//  MainScreenPresenter.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 01.02.2023.
//

import Foundation

// MARK: - MainScreenPresenterProtocol
protocol MainScreenPresenterProtocol: AnyObject {
    func viewLoaded()
    func getWeather(for city: City)
    func cityButtonDidPress()
    func mapButtonDidPress()
}

// MARK: - MainScreenPresenter
final class MainScreenPresenter {

    // MARK: - Public properties
    weak var view: MainScreenTableViewProtocol?
    
    // MARK: - Private properties
    private let network = WeatherApp.shared.network
    private let locationService = LocationServices.shared
    private var weatherData: WeatherData?
    private var city: City?
    
    // MARK: - Lifecycle
    init(view: MainScreenTableViewProtocol) {
        self.view = view
    }
}

// MARK: - MainScreenPresenterProtocol implementation
extension MainScreenPresenter: MainScreenPresenterProtocol {
    func viewLoaded() {
        view?.setupUI(for: weatherData, city: city)
        locationService.delegate = self
    }
    
    func getWeather(for city: City) {
        view?.showLoader()
        network.getWeather(latitude: city.latitude, longitude: city.longitude)
            .done { [weak self] weatherData in
                self?.view?.hideLoader()
                self?.weatherData = weatherData
                self?.view?.setupUI(for: weatherData, city: city)
                self?.view?.reloadData()
            }
            .catch { [weak self] error in
                self?.view?.hideLoader()
                Log.error(error.localizedDescription)
            }

    }
    
    func cityButtonDidPress() {
        view?.pushSearchViewController()
    }
    
    func mapButtonDidPress() {
        view?.pushMapViewController()
    }
}

// MARK: - LocationServiceDelegate implementation
extension MainScreenPresenter: LocationServiceDelegate {
    func updateCity(city: City) {
        getWeather(for: city)
    }
}
