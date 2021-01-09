//
//  ISettingsViewOutput.swift
//  News
//
//  Created by Ацкий Станислав on 09.01.2021.
//

import Foundation

protocol ISettingsViewOutput: class {
    var rssSubscriptions: [RSSSource] {get set}
    var refreshInterval: TimeInterval {get set}
}
