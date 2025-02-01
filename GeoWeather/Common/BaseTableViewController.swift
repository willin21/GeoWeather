//
//  BaseTableViewController.swift
//  GeoWeather
//
//  Created by william niño on 29/01/25.
//

import UIKit
import Foundation

class BaseTableViewController: UITableViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
