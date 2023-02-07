//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 29.01.2023.
//

import Moya

struct WeatherApp {

    // MARK: - Public Properties
    static let shared = WeatherApp()

    let network: WeatherAppNetwork

    // MARK: - Private Init
    private init() {
        let config = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let loggerPlugin = NetworkLoggerPlugin(configuration: config)

        let converter = JSONDataConverterService()

        network = WeatherAppNetwork(
            converter: converter,
            plugins: [loggerPlugin])
    }
}
