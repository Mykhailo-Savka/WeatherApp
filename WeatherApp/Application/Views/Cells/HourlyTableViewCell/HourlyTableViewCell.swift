//
//  HourlyTableViewCell.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 01.02.2023.
//

import UIKit

// MARK: - HourlyTableViewCell
final class HourlyTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Private properties
    private var hourWeatherList: [Current] = []
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    // MARK: - Public methods
    func configure(hourWeatherList: [Current]) {
        self.hourWeatherList = hourWeatherList
        reloadData()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    // MARK: - Private methods
    private func setupCell() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(HourlyCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDelegate implementation
extension HourlyTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourWeatherList.count
    }
}

// MARK: - UICollectionViewDataSource implementation
extension HourlyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(HourlyCollectionViewCell.self,
                                              indexPath: indexPath)
        let hourWeather = hourWeatherList[indexPath.row]
        cell.configure(hour: hourWeather.converting(),
                       temperature: hourWeather.tempString,
                       weatherImage: UIImage(systemName: hourWeather.weather.first?.iconFormatter ?? ""))
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout implementation
extension HourlyTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 140)
    }
}
