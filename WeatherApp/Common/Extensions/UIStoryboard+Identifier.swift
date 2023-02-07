//
//  UIStoryboard+Identifier.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 31.01.2023.
//

import UIKit

extension UIStoryboard {
    var identifier: String {
        return String(describing: self)
    }
}
