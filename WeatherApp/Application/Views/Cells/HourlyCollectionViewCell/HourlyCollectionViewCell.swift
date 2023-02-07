//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 01.02.2023.
//

import UIKit

// MARK: - HourlyCollectionViewCell
final class HourlyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherIcon: UIImageView!

    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        hourLabel.text = nil
        temperatureLabel.text = nil
        weatherIcon.image = nil
    }
    
    // MARK: - Public methods
    func configure(hour: String, temperature: String, weatherImage: UIImage?) {
        hourLabel.text = hour
        temperatureLabel.text = temperature
        weatherIcon.image = weatherImage
    }
}
