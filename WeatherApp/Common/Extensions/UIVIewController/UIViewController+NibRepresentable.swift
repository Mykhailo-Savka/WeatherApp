//
//  UIViewController+NibRepresentable.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 31.01.2023.
//

import UIKit

extension UIViewController: NibRepresentable {
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    class var identifier: String {
        return String(describing: self)
    }
}
