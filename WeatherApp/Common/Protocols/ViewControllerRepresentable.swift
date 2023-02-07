//
//  ViewControllerRepresentable.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 31.01.2023.
//

import UIKit

protocol ViewControllerRepresentable: AnyObject {
    var view: UIView! { get }
}
