//
//  AppRouter.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 31.01.2023.
//

import Foundation
import UIKit

// MARK: - AppRouter
class AppRouter {
    
    // MARK: - Life cycle
    private init() {}
    
    // MARK: - Public properties
    static let instance = AppRouter()
    
    // MARK: - Public functions
    func startApp(window: UIWindow?) {
        showMainScreen(window: window)
    }
    
    // MARK: - Private functions
    private func showMainScreen(window: UIWindow?) {
        let mainScreenTableViewController = MainScreenTableViewController.instantiateFromStoryboard()
        let presenter = MainScreenPresenter(view: mainScreenTableViewController)
        mainScreenTableViewController.presenter = presenter
        let navigationViewController = UINavigationController(rootViewController: mainScreenTableViewController)
        window?.rootViewController = navigationViewController
    }
}
