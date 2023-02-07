//
//  Daily.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 29.01.2023.
//

import Foundation

// MARK: - Daily
struct Daily: Codable {
    let dt, sunrise, sunset, moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let temp: Temp
    let pressure, humidity: Double?
    let dewPoint, windSpeed: Double?
    let windDeg: Double?
    let windGust: Double?
    let weather: [Weather]
    let clouds: Double?
    let pop, rain, uvi: Double?
    
    func dayOfTheWeek() -> String {
        let date = Date(timeIntervalSince1970: Double(dt))
        let weekdays = [
            "НД",
            "ПН",
            "ВТ",
            "СР",
            "ЧТ",
            "ПТ",
            "СБ"
        ]
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        let components: DateComponents = calendar.components(.weekday, from: date)
        
        return weekdays[(components.weekday ?? 0) - 1]
    }
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, rain, uvi
    }
}
