//
//  LocationListViewController.swift
//  GeoWeather
//
//  Created by william niño on 29/01/25.
//

import UIKit
import Foundation
import SafariServices

class LocationListViewController: BaseTableViewController {

    private let viewModel: LocationListViewModel
    
    required init(viewModel: LocationListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    private func configureTableView() {
        tableView.register(LocationListTableViewCell.self)
        tableView.registerHeaderFooter(LocationHeaderTableViewCell.self)
    }
    
    //MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 0 ? 92 : 82
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = viewModel.cities[indexPath.row]
        viewModel.presentForecast(for: city, query: city.name)
    }
    
    //MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = viewModel.cities[indexPath.row]
        let cell: LocationListTableViewCell = tableView.dequeueReusableCell()
        cell.configure(with: city)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try? viewModel.deleteCity(at: indexPath.row)
            self.showToast(message: Constants.Text.forecastRemoved)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: LocationHeaderTableViewCell = tableView.dequeueReusableHeaderFooterView()
        headerView.delegate = self
        headerView.configure(for: viewModel.temperatureUnit)
        
        return headerView
    }
}

extension LocationListViewController: HeaderViewDelegate {
    func didPressWeatherButton() {
        openSafariVC()
    }
    
    func didPressSearchButton() {
        viewModel.presentCitySearch()
    }
}

extension LocationListViewController: SFSafariViewControllerDelegate {
    func openSafariVC() {
        if let url = URL(string: Constants.openWeatherWebURL) {
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
