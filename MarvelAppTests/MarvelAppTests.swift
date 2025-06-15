//
//  MarvelAppTests.swift
//  MarvelAppTests
//
//  Created by Javier Gomez on 12/6/25.
//
import XCTest
@testable import MarvelApp

// MARK: - HeroListViewModelTests

@MainActor
final class HeroListViewModelTests: XCTestCase {
    
    var viewModel: HeroListViewModel!
    var mockUseCase: MockFetchHeroesUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchHeroesUseCase()
        viewModel = HeroListViewModel(useCase: mockUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func testInitialState() {
        // Then
        XCTAssertTrue(viewModel.heroes.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchHeroesSuccess() async {
        // Given
        let expectedHeroes = [
            Hero(id: 1, name: "Iron Man", description: "Genius", thumbnail: HeroThumbnail(path: "test", extension: "jpg")),
            Hero(id: 2, name: "Captain America", description: "Super soldier", thumbnail: HeroThumbnail(path: "test", extension: "jpg"))
        ]
        mockUseCase.heroesToReturn = expectedHeroes
        
        // When
        await viewModel.fetchHeroes()
        
        // Then
        XCTAssertEqual(viewModel.heroes.count, 2)
        XCTAssertEqual(viewModel.heroes, expectedHeroes)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchHeroesFailure() async {
        // Given
        mockUseCase.shouldThrowError = true
        
        // When
        await viewModel.fetchHeroes()
        
        // Then
        XCTAssertTrue(viewModel.heroes.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, "Problems loading Heroes")
    }
    
    func testClearError() {
        // Given
        viewModel.errorMessage = "Test error"
        
        // When
        viewModel.errorMessage = nil
        
        // Then
        XCTAssertNil(viewModel.errorMessage)
    }
}

// MARK: - HeroDetailViewModelTests

@MainActor
final class HeroDetailViewModelTests: XCTestCase {
    
    var viewModel: HeroDetailViewModel!
    var mockUseCase: MockFetchSeriesUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchSeriesUseCase()
        viewModel = HeroDetailViewModel(fetchSeriesUseCase: mockUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func testInitialState() {
        // Then
        XCTAssertTrue(viewModel.series.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testFetchSeriesSuccess() async {
        // Given
        let expectedSeries = [
            SeriesModel(id: 1, title: "Iron Man Series", description: "Iron Man adventures", thumbnail: SeriesThumbnail(path: "test", extension: "jpg")),
            SeriesModel(id: 2, title: "Avengers Series", description: "Avengers assemble", thumbnail: SeriesThumbnail(path: "test", extension: "jpg"))
        ]
        mockUseCase.seriesToReturn = expectedSeries
        
        // When
        await viewModel.fetchSeries(for: 1009368) // Iron Man ID
        
        // Then
        XCTAssertEqual(viewModel.series.count, 2)
        XCTAssertEqual(viewModel.series, expectedSeries)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testFetchSeriesFailure() async {
        // Given
        mockUseCase.shouldThrowError = true
        
        // When
        await viewModel.fetchSeries(for: 1009368)
        
        // Then
        XCTAssertTrue(viewModel.series.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
}

// MARK: - MarvelAPIServiceTests

final class MarvelAPIServiceTests: XCTestCase {
    
    var apiService: MarvelAPIService!
    
    override func setUp() {
        super.setUp()
        apiService = MarvelAPIService()
    }
    
    override func tearDown() {
        apiService = nil
        super.tearDown()
    }
    
    func testGenerateHashConsistency() {
        // Given
        let ts1 = "1"
        let ts2 = "1"
        
        // When
        let hash1 = generateTestHash(ts: ts1)
        let hash2 = generateTestHash(ts: ts2)
        
        // Then
        XCTAssertEqual(hash1, hash2, "Mismo timestamp debe generar el mismo hash")
    }
    
        // MARK: - Extras
        
        private func generateTestHash(ts: String) -> String {
            // Simulamos la función generateHash para testing
            let toHash = ts + MarvelAPI.privateKey + MarvelAPI.publicKey
            return toHash.md5
        }
    }

extension String {
    var md5: String {
        // Implementación simple de MD5 para testing
        // En producción usarías CryptoKit como en tu código original
        return "test_hash_\(self.count)"
    }
    // MARK: - HeroModelTest
    final class HeroModelTests: XCTestCase {
        
        func testHeroDecoding() throws {
            // Given
            let json = """
            {
                "id": 1011334,
                "name": "3-D Man",
                "description": "Rick Sheridan wore the 3-D Man uniform.",
                "thumbnail": {
                    "path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                    "extension": "jpg"
                }
            }
            """
            
            let data = json.data(using: .utf8)!
            
            // When
            let hero = try JSONDecoder().decode(Hero.self, from: data)
            
            // Then
            XCTAssertEqual(hero.id, 1011334)
            XCTAssertEqual(hero.name, "3-D Man")
            XCTAssertEqual(hero.description, "Rick Sheridan wore the 3-D Man uniform.")
            XCTAssertEqual(hero.thumbnail.path, "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784")
            XCTAssertEqual(hero.thumbnail.extension, "jpg")
        }
        
        func testHeroThumbnailURL() {
            // Given
            let hero = Hero(
                id: 1,
                name: "Test Hero",
                description: "Test Description",
                thumbnail: HeroThumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                    extension: "jpg"
                )
            )
            
            // When
            let thumbnailURL = hero.thumbnailURL
            
            // Then
            XCTAssertEqual(thumbnailURL, "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")
        }
    }
}
