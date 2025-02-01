//
//  SearchLocationViewController.swift
//  GeoWeather
//
//  Created by william niño on 29/01/25.
//

import UIKit
import Foundation

class SearchLocationViewController: BaseTableViewController {
    
    private var viewModel: SearchLocationViewModel
    private let searchController = UISearchController(searchResultsController: nil)
    private var cities = [City]()
    
    required init(viewModel: SearchLocationViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        configureTableView()
    }
    
    // MARK: Configuration
    
    private func configureTableView() {
        tableView.tableHeaderView = searchController.searchBar
    }
    
    private func configureSearchBar() {
        searchController.searchBar.searchTextField.textColor = .black
        searchController.searchBar.searchTextField.tintColor = .black
        searchController.searchBar.tintColor = .black
        searchController.searchBar.barStyle = .black
        searchController.searchBar.delegate = self
        searchController.searchBar.showsCancelButton = true
        searchController.automaticallyShowsScopeBar = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .black
        }
    }
    
    private func dismissAll(_ completion: (() -> Void)? = nil) {
        searchController.dismiss(animated: false) { [weak self] in
            self?.dismiss(animated: true) {
                completion?()
            }
        }
    }
    
    //MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCity(city: cities[indexPath.row])
        dismissAll()
    }
    
    //MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = cities[indexPath.row]
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "LoctationCellIdentifier")
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.textLabel?.text = (city.name + ", " + city.region + ", " + city.country)
        
        return cell
    }
}

extension SearchLocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        viewModel.searchLocation(query: searchText) { result in
            self.cities = result
            self.tableView.reloadData()
        } errorMessage: { error in
            print(error)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismissAll()
    }
}
