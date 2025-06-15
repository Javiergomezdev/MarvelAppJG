//
//  FetchSeriesUseCaseProtocol.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//

import Foundation

protocol FetchSeriesUseCaseProtocol {
    func fetchSeries(for heroId: Int) async throws -> [SeriesModel]
}
