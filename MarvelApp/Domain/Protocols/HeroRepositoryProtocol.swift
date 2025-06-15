//
//  HeroRepositoryProtocol.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//


protocol HeroRepositoryProtocol {
    func getHeroes() async throws -> [Hero]
}
