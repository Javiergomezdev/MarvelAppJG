//
//  FetchHeroesUseCaseProtocol.swift
//  MarvelApp
//
//  Created by Javier Gomez on 15/6/25.
//


import Foundation

protocol FetchHeroesUseCaseProtocol {
    func getHeroes() async throws -> [Hero]
}