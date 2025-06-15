//
//  FetchSeriesUseCase.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//

import Foundation

final class FetchSeriesUseCase: FetchSeriesUseCaseProtocol {
    private let repository: SerieRepositoryProtocol
    
    init(repository: SerieRepositoryProtocol = SerieRepository()) {
        self.repository = repository
    }
    
    func fetchSeries(for heroId: Int) async throws -> [SeriesModel] {
        try await repository.getSeries(for: heroId)
    }
}
