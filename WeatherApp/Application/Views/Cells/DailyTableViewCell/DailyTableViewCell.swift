//
//  DailyTableViewCell.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 01.02.2023.
//

import UIKit

// MARK: - DailyTableViewCell
final class DailyTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherIcon: UIImageView!
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        dayLabel.text = nil
        temperatureLabel.text = nil
        weatherIcon.image = nil
    }
    
    // MARK: - Public methods
    func configure(day: String, temperature: String, weatherImage: UIImage?) {
        dayLabel.text = day
        temperatureLabel.text = temperature
        weatherIcon.image = weatherImage
    }
}
