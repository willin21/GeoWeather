//
//  SplashViewConrtoller.swift
//  GeoWeather
//
//  Created by william niño on 28/01/25.
//

import UIKit
import Lottie
import Then
import SnapKit

class SplashViewController: UIViewController {
    
    private let windowScreen: UIWindow
    
    init(windowScreen: UIWindow) {
        self.windowScreen = windowScreen
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var labelTitulo = UILabel()
        .then { $0.text = "Geo Weather" }
        .then { $0.textColor = .black }
        .then { $0.font = .systemFont(ofSize: 32, weight: .bold) }
        .then { $0.textAlignment = .center }
        .then { view.addSubview($0) }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarConstraints()
        startAnimation()
        goToHomeView()
    }
    
    func goToHomeView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let navigation = NavigationFrame(window: self.windowScreen)
            navigation.presentMainScreen()
        }
    }
    
    func configurarConstraints() {
        labelTitulo.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-260)
        }
    }
    
    func startAnimation() {
        var animationView = LottieAnimationView()
        animationView = .init(name: "WeatherAnimation")
        animationView.frame = CGRect(x: 0, y: 0, width: 220, height: 220)
        animationView.center = view.center
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1.5
        
        view.addSubview(animationView)
        view.backgroundColor = .lightText
        animationView.play()
    }
}
