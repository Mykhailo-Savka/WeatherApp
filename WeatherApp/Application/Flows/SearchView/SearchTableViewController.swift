//
//  SearchTableViewController.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 04.02.2023.
//

import UIKit
import MapKit

// MARK: - SearchTableViewControllerProtocol
protocol SearchTableViewControllerProtocol: AnyObject {
    func setupUI()
    func reloadData()
    func popViewController()
}

// MARK: - SearchTableViewController
final class SearchTableViewController: UITableViewController {
    
    // MARK: - Public properties
    var presenter: SearchTableViewPresenterProtocol!
    
    // MARK: - Private properties
    private var searchCompleter = MKLocalSearchCompleter()
    private let searchTextField = UITextField()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }
    
    // MARK: - TableView delegate and datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = presenter.searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = presenter.searchResults[indexPath.row]
        presenter.getLocation(result)
    }
    
    // MARK: - Private methods
    private func createSearchBarTextField() {
        searchTextField.frame = CGRect(x: 0,
                                       y: 0,
                                       width: (navigationController?.navigationBar.frame.size.width ?? 0) - 100,
                                       height: 21)
        searchTextField.backgroundColor = .white
        searchTextField.borderStyle = .roundedRect
        searchTextField.addTarget(self,
                                  action: #selector(searchTextFieldDidChanged(_ :)),
                                  for: .editingChanged)
        navigationItem.titleView = searchTextField
    }
    
    // MARK: - @objc private method
    @objc private func searchTextFieldDidChanged(_ sender: UITextField) {
        if let text = sender.text {
            searchCompleter.queryFragment = text
        }
    }
    
    // MARK: - IBActions
    @IBAction private func onBackButton(_ sender: UIButton) {
        popViewController()
    }
    
    @IBAction private func onSearchButton(_ sender: UIButton) {
        searchTextField.becomeFirstResponder()
    }
}

// MARK: - SearchTableViewControllerProtocol implementation
extension SearchTableViewController: SearchTableViewControllerProtocol {
    func setupUI() {
        searchCompleter.delegate = self
        createSearchBarTextField()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - MKLocalSearchCompleterDelegate implementation
extension SearchTableViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        presenter.getResults(completer.results)
    }
}
