//
//  MainScreenTableViewController.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 01.02.2023.
//

import UIKit
import JGProgressHUD

// MARK: - MainScreenTableViewProtocol
protocol MainScreenTableViewProtocol: LoadingHandlerProtocol {
    func setupUI(for weatherData: WeatherData?, city: City?)
    func reloadData()
    func pushSearchViewController()
    func pushMapViewController()
}

// MARK: - MainScreenTableViewController
final class MainScreenTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var cityButton: UIButton!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var windLabel: UILabel!
    
    // MARK: - Public properties
    var presenter: MainScreenPresenterProtocol!
    let hud = JGProgressHUD()
    
    // MARK: - Private properties
    private var weatherData: WeatherData?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    // MARK: - TableView delegate and datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return weatherData?.daily.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherData else { return UITableViewCell(style: .default, reuseIdentifier: "Cell") }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueCell(HourlyTableViewCell.self, indexPath: indexPath)
            cell.configure(hourWeatherList: weatherData.hourly)
            return cell
        default:
            let day = weatherData.daily[indexPath.row]
            let cell = tableView.dequeueCell(DailyTableViewCell.self, indexPath: indexPath)
            cell.configure(day: day.dayOfTheWeek(),
                           temperature: "\(day.temp.maxString) / \(day.temp.minString)",
                           weatherImage: UIImage(systemName: day.weather.first?.iconFormatter ?? ""))
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            guard let hourly = weatherData?.hourly, !hourly.isEmpty else { return 0 }
            return 140
        default:
            return UITableView.automaticDimension
        }
    }
    
    // MARK: - Private methods
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 0.3527679443, green: 0.6399899125, blue: 0.9096029401, alpha: 1)
        appearance.shadowColor = .clear

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: - IBActions
    @IBAction private func onCityButton(_ sender: UIButton) {
        presenter.cityButtonDidPress()
    }
    
    @IBAction private func onMapButton(_ sender: UIButton) {
        presenter.mapButtonDidPress()
    }
}

// MARK: - MainScreenTableViewProtocol implementation
extension MainScreenTableViewController: MainScreenTableViewProtocol {
    func setupUI(for weatherData: WeatherData?, city: City?) {
        tableView.registerCell(HourlyTableViewCell.self)
        tableView.registerCell(DailyTableViewCell.self)
        self.weatherData = weatherData
        cityButton.setTitle(city?.city, for: .normal)
        dateLabel.text = weatherData?.current.mainDateString()
        weatherImage.image = UIImage(systemName: weatherData?.current.weather.first?.iconFormatter ?? "")
        if let dayTemp = weatherData?.daily.first?.temp {
            temperatureLabel.text = dayTemp.maxString + " / " + dayTemp.minString
        }
        if let current = weatherData?.current {
            humidityLabel.text = "\(current.humidity)%"
            windLabel.text = "\(Int(current.windSpeed))м/с"
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func pushSearchViewController() {
        let searchViewController = SearchTableViewController.instantiateFromStoryboard()
        let presenter = SearchTableViewPresenter(view: searchViewController)
        searchViewController.presenter = presenter
        presenter.callBack = { [weak self] city in
            self?.presenter.getWeather(for: city)
        }
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func pushMapViewController() {
        let mapViewController = MapViewController.instantiateFromStoryboard()
        let presenter = MapViewPresenter(view: mapViewController)
        mapViewController.presenter = presenter
        presenter.callBack = { [weak self] city in
            self?.presenter.getWeather(for: city)
        }
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}
