//
//  Temp.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 29.01.2023.
//

import Foundation

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
    
    var minString: String {
        return "\(Int(min.rounded()))°"
    }
    
    var maxString: String {
        return "\(Int(max.rounded()))°"
    }
}
