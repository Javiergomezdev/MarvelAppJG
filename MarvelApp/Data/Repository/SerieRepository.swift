//
//  Untitled.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//

import Foundation
final class SerieRepository: SerieRepositoryProtocol {
    
    private let service: MarvelAPIService
    
    init(service: MarvelAPIService = MarvelAPIService()) {
        self.service = service
    }
    
    func getSeries(for heroId: Int) async throws -> [SeriesModel] {
        try await service.getSeries(for: heroId)
    }
    
    
    
}
