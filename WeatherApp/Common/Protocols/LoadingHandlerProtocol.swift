//
//  LoadingHandlerProtocol.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 06.02.2023.
//

import UIKit
import JGProgressHUD

protocol LoadingHandlerProtocol: UITableViewController {
    var hud: JGProgressHUD { get }
    
    func showLoader()
    func hideLoader()
}

extension LoadingHandlerProtocol {
    func showLoader() {
        hud.show(in: view)
    }

    func hideLoader() {
        hud.dismiss()
    }
}
