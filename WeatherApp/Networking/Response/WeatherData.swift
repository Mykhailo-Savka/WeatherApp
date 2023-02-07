//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 29.01.2023.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let hourly: [Current]
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon
        case timezone
        case timezoneOffset = "timezone_offset"
        case current
        case hourly
        case daily
    }
}
