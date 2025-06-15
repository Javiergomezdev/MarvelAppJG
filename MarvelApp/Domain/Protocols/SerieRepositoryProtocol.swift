//
//  SerieRepositoryProtocol.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//
import Foundation

protocol SerieRepositoryProtocol {
    func getSeries(for heroId: Int) async throws -> [SeriesModel]
}
