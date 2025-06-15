//
//  FetchHeroesUseCase.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//
import Foundation

final class FetchHeroesUseCase: FetchHeroesUseCaseProtocol {
    
    private let repository: HeroRepositoryProtocol
    
    init(repository: HeroRepositoryProtocol) {
        self.repository = repository
    }
    
    func getHeroes() async throws -> [Hero] {
        try await repository.getHeroes()
    }
}

