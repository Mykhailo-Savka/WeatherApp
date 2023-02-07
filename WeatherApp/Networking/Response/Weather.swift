//
//  Weather.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 29.01.2023.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let icon: String?
    
    var iconFormatter: String {
        switch icon {
        case "11d": return "cloud.bolt.rain"
        case "09d": return "cloud.drizzle"
        case "13d": return "cloud.snow"
        case "10d": return "cloud.rain"
        case "50d": return "cloud.fog"
        case "01d", "01n": return "sun.max"
        case "02d", "02n": return "cloud.sun"
        case "03d", "03n", "04d", "04n": return "cloud"
        default: return "cloud"
        }
    }
}
