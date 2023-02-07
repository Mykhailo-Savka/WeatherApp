//
//  WeatherAppNetwork.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 29.01.2023.
//

import Moya

final class WeatherAppNetwork: Networkable {

    let provider: MoyaProvider<WeatherAppProvider>
    let dataConverter: JSONDataConverterService

    init(converter: JSONDataConverterService,
         plugins: [PluginType],
         interceptor: EnvironmentInterceptor = EnvironmentInterceptor()) {
        self.dataConverter = converter
        let session = Session(startRequestsImmediately: false, interceptor: interceptor)
        let provider = MoyaProvider<WeatherAppProvider>(session: session, plugins: plugins)
        self.provider = provider
    }
    
    func getWeather(latitude: Double, longitude: Double) -> WeatherPromise<WeatherData> {
        return executeAndMap(request: .getWeather(latitude: latitude, longitude: longitude))
    }
}
