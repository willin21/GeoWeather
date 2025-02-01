//
//  DetailForecastViewController.swift
//  GeoWeather
//
//  Created by william niño on 30/01/25.
//

import Foundation
import UIKit
import MBProgressHUD

class DetailForecastViewController: BaseCollectionViewController {
    
    private let viewModel: DetailForecastProtocol
    private let layout: DetailForecastCollectionViewLayout
    private let query: String
    private var hud: MBProgressHUD?
    
    required init(viewModel: DetailForecastProtocol, query: String) {
        self.viewModel = viewModel
        self.query = query
        self.layout = DetailForecastCollectionViewLayout(viewModel: viewModel)
        super.init(collectionViewLayout: self.layout.createLayout())
    }
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureNavigationBar()
        configureToolBar()
        configureBindings()
        
        viewModel.requestForecast()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: Configuration
    
    private func configureCollectionView() {
        collectionView.register(ActivityIndicatorCollectionViewCell.self)
        collectionView.register(CityCollectionViewCell.self)
        collectionView.register(TemperatureCollectionViewCell.self)
        collectionView.register(HourForecastCollectionViewCell.self)
    }
    
    private func configureBindings() {
        showLoading()
        
        viewModel.getForecast(query: query) {
            self.collectionView.reloadData()
            self.hideLoading()
        } errorMessage: { error in
            self.handleError(error: error)
            self.hideLoading()
        }
    }
    
    func showLoading() {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud?.label.text = Constants.Text.loading
    }

    func hideLoading() {
        hud?.hide(animated: true)
    }
    
    private func configureNavigationBar() {
        guard !viewModel.isSaved else { return }
        
        navigationController?.navigationBar.isHidden = false
        
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(didTapAdd(_:)))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel(_:)))
        
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func configureToolBar() {
        navigationController?.isToolbarHidden = false
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(didTapCancel(_:)))
        
        toolbarItems = [spacer, listButton]
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.dataSource.sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dataSource.sections[section].numberOfItems
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.dataSource.sections[indexPath.section]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: section.cellClass.reuseIdentifier,
                                                      for: indexPath) as! ForecastViewRepresentable
        
        cell.configure(with: section, indexPath: indexPath)
        
        return cell
    }
    
    private func handleError(error: String) {
        presentRetryAlert(withTitle: "Oops", message: error) { [weak self] _ in
            self?.viewModel.requestForecast()
        }
    }
    
    // MARK: Actions
    
    @objc func didTapAdd(_ sender: UIBarButtonItem) {
        do {
            try viewModel.saveCity()
            self.showToast(message: Constants.Text.forecastAdded)
            navigationController?.navigationBar.isHidden = viewModel.isSaved
        } catch {
            self.handleError(error: Constants.Text.Error.addingForecast + " \(error)")
        }
    }
    
    @objc func didTapCancel(_ sender: UIBarButtonItem) {
        viewModel.didPressCityList()
    }
    
}
