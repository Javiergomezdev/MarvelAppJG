//
//  MockFetchSeriesUseCase.swift
//  MarvelApp
//
//  Created by Javier Gomez on 15/6/25.
//


import XCTest
@testable import MarvelApp

class MockFetchSeriesUseCase: FetchSeriesUseCaseProtocol {
    var seriesToReturn: [SeriesModel] = []
    var shouldThrowError = false
    var callCount = 0
    var delay: TimeInterval = 0
    
    func fetchSeries(for heroId: Int) async throws -> [SeriesModel] {
        callCount += 1
        
        if delay > 0 {
            try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        }
        
        if shouldThrowError {
            throw URLError(.networkConnectionLost)
        }
        
        return seriesToReturn
    }
}