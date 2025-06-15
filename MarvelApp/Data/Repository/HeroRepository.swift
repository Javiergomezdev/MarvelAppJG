//
//  HeroRepository.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//


final class HeroRepository: HeroRepositoryProtocol {
    
    private let service: MarvelAPIService
    
    init(service: MarvelAPIService = MarvelAPIService()) {
        self.service = service
    }
    
    func getHeroes() async throws -> [Hero] {
        try await service.getHeroes()
    }
}
