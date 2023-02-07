//
//  Current.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 29.01.2023.
//

import Foundation

// MARK: - Current
struct Current: Codable {
    let dt: Int
    let sunrise, sunset: Int?
    let temp: Double
    let pressure, humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double?
    let weather: [Weather]
    let pop: Double?
    
    var tempString: String {
        return "\(Int(temp.rounded()))°"
    }
    
    func converting() -> String {
        let date = Date(timeIntervalSince1970: Double(dt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let dtString = dateFormatter.string(from: date)
        return dtString
    }
    
    func mainDateString() -> String {
        let date = Date(timeIntervalSince1970: Double(dt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, dd MMMM"
        let dtString = dateFormatter.string(from: date)
        return dtString
    }
    
    enum CodingKeys: String, CodingKey {
        case dt
        case sunrise, sunset
        case temp
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, pop
    }
}
