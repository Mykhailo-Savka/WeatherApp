//
//  ReachabilityManager.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 29.01.2023.
//

import Foundation
import Alamofire

// MARK: - ReachabilityManagerDelegate
protocol ReachabilityManagerDelegate: AnyObject {
    func statusChanged(isReachable: Bool)
}

// MARK: - ReachabilityManager
final class ReachabilityManager {
    
    // MARK: - Private properties
    private let reachabilityManager = NetworkReachabilityManager.default
    
    // MARK: - Public properties
    weak var delegate: ReachabilityManagerDelegate?
    
    // MARK: - Life Cycle
    init() {
        self.setupManager()
    }
    
    // MARK: - Private methods
    private func setupManager() {
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            self.delegate?.statusChanged(isReachable: status != .notReachable)
        })
    }
}
