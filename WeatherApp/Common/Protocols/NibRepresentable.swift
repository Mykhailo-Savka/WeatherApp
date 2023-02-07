//
//  NibRepresentable.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 31.01.2023.
//

import UIKit

protocol NibRepresentable {
    static var nib: UINib { get }
    static var identifier: String { get }
}
