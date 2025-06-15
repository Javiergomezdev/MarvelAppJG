//
//  HeroListViewModel.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//

//
//  HeroListViewModel.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//

import Foundation

@MainActor
final class HeroListViewModel: ObservableObject {
    @Published var heroes: [Hero] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let fetchHeroesUseCase: FetchHeroesUseCaseProtocol
    

    init(useCase: FetchHeroesUseCaseProtocol? = nil) {
        let defaultUseCase: FetchHeroesUseCaseProtocol = FetchHeroesUseCase(repository: HeroRepository())
        self.fetchHeroesUseCase = useCase ?? defaultUseCase
    }
    
    func fetchHeroes() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedHeroes = try await fetchHeroesUseCase.getHeroes()
            self.heroes = fetchedHeroes
        } catch {
            self.errorMessage = "Problems loading Heroes"
        }
        
        isLoading = false
    }

}
