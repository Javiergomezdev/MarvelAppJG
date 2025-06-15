//
//  HeroDetailViewModel.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//

import Foundation

@MainActor
final class HeroDetailViewModel: ObservableObject {
    @Published var series: [SeriesModel] = []
    @Published var isLoading = false
    
    private let fetchSeriesUseCase: FetchSeriesUseCaseProtocol
    
    init(fetchSeriesUseCase: FetchSeriesUseCaseProtocol = FetchSeriesUseCase(repository: SerieRepository())) {
        self.fetchSeriesUseCase = fetchSeriesUseCase
    }
    
    func fetchSeries(for heroId: Int) async {
        guard !isLoading else { return }
        
        isLoading = true
        
        do {
            let fetchedSeries = try await fetchSeriesUseCase.fetchSeries(for: heroId)
            self.series = fetchedSeries
        } catch {
            self.series = []
        }
        
        isLoading = false
    }
}
