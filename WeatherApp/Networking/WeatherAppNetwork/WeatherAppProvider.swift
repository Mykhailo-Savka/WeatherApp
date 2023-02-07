//
//  WeatherAppProvider.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 29.01.2023.
//

import Moya

private let cUrlPath = "https://api.openweathermap.org"

enum WeatherAppProvider {
    
    case getWeather(latitude: Double, longitude: Double)
    
}

extension WeatherAppProvider: TargetType {
    
    var baseURL: URL {
        return URL(string: cUrlPath)!
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return "/data/2.5/onecall"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getWeather(let latitude, let longitude):
            let parameters = ["lat": "\(latitude)",
                              "lon": "\(longitude)",
                              "appid": "bc40f564aa6b1e7142c5ea7bcc71da42",
                              "exclude": "minutely",
                              "units": "metric"]
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        let parameters: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "*/*"
        ]
        return parameters
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
