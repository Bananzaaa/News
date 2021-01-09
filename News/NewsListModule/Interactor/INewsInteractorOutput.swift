//
//  INewsInteractorOutput.swift
//  News
//
//  Created by Ацкий Станислав on 09.01.2021.
//

import Foundation

protocol INewsInteractorOutput: class {
    func cachedNews(_ news: [NewsItem])
    func freshNews(_ news: [NewsItem])
}
