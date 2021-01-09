//
//  ConfigurableView.swift
//  News
//
//  Created by Ацкий Станислав on 06.01.2021.
//

import Foundation

protocol IConfigurableView {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
