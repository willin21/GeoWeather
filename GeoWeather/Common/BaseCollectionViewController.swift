//
//  BaseCollectionViewController.swift
//  GeoWeather
//
//  Created by william niño on 30/01/25.
//

import Foundation
import UIKit

class BaseCollectionViewController: UICollectionViewController {
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
