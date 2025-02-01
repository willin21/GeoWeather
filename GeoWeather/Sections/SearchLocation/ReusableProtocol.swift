//
//  ReusableView.swift
//  GeoWeather
//
//  Created by william niño on 30/01/25.
//

import Foundation
import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String { String(describing: self) }
}
protocol NibLoadableView {
    static var nibName: String { get }
}

extension NibLoadableView {
    static var nibName: String { String(describing: self) }
}

protocol ResettableView {
    func reset()
}
