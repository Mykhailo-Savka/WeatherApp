//
//  SearchTableViewPresenter.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 05.02.2023.
//

import Foundation
import MapKit

// MARK: - SearchTableViewPresenterProtocol
protocol SearchTableViewPresenterProtocol: AnyObject {
    var searchResults: [MKLocalSearchCompletion] { get }
    
    func viewLoaded()
    func getResults(_ results: [MKLocalSearchCompletion])
    func getLocation(_ result: MKLocalSearchCompletion)
}

// MARK: - SearchTableViewPresenter
final class SearchTableViewPresenter {
    
    // MARK: - Public properties
    weak var view: SearchTableViewControllerProtocol?
    var callBack: ((City) -> Void)?
    
    // MARK: - Private properties
    private (set) var searchResults: [MKLocalSearchCompletion] = []
    
    // MARK: - Lifecycle
    init(view: SearchTableViewControllerProtocol) {
        self.view = view
    }
    
    // MARK: - Private methods
    private func searchingResults(_ result: MKLocalSearchCompletion,
                                  completion: @escaping (_ city: City) -> Void) {
        let searchRequest = MKLocalSearch.Request(completion: result)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let coordinate = response?.mapItems[.zero].placemark.coordinate,
                  let name = response?.mapItems[.zero].name else {
                return
            }
            var city = City()
            city.city = name
            city.latitude = coordinate.latitude
            city.longitude = coordinate.longitude
            
            completion(city)
        }
    }
}

// MARK: - SearchTableViewPresenterProtocol implementation
extension SearchTableViewPresenter: SearchTableViewPresenterProtocol {
    func viewLoaded() {
        view?.setupUI()
    }
    
    func getResults(_ results: [MKLocalSearchCompletion]) {
        searchResults = results
        view?.reloadData()
    }
    
    func getLocation(_ result: MKLocalSearchCompletion) {
        searchingResults(result) { city in
            self.callBack?(city)
            self.view?.popViewController()
        }
    }
}
