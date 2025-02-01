//
//  NavigationFrame.swift
//  GeoWeather
//
//  Created by william niño on 29/01/25.
//

import UIKit

protocol NavigationFrameProtocol {
    var window: UIWindow { get }
    
    func presentMainScreen()
    func presentLocationList()
    func presentSearchLocation()
    func presentForecast(for city: City, query: String)
    func didPressCityListButton()
}

struct NavigationFrame: NavigationFrameProtocol {
    
    let window: UIWindow
    
    private let navigationController = UINavigationController()
    
    func presentMainScreen() {
        presentLocationList()
        
        if FavouritesHelper.shared.getFavorites().isEmpty {
            presentSearchLocation()
        }
    }
    
    func presentLocationList() {
        let viewModel = LocationListViewModel(navigationFrame: self)
        let viewController = LocationListViewController(viewModel: viewModel)
        
        navigationController.viewControllers = [viewController]
        navigationController.navigationBar.isHidden = true
        navigationController.modalPresentationStyle = .fullScreen

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func presentSearchLocation() {
        let viewModel = SearchLocationViewModel(navigationFrame: self)
        let viewController = SearchLocationViewController(viewModel: viewModel)

        navigationController.present(viewController, animated: true)
    }
    
    func presentForecast(for city: City, query: String) {
        let viewModel = DetailForecastViewModel(city: city, navitationFrame: self)
        let viewController = DetailForecastViewController(viewModel: viewModel, query: query)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func didPressCityListButton() {
        navigationController.navigationBar.isHidden = true
        navigationController.visibleViewController?.dismissOrPop()
    }
}

