//
//  MarvelAPIService.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//
import Foundation
import CryptoKit

final class MarvelAPIService {
    
    func getHeroes() async throws -> [Hero] {
        let ts = String(Int(Date().timeIntervalSince1970))
        let hash = generateHash(ts: ts)
        let urlString = "\(MarvelAPI.baseURL)characters?ts=\(ts)&apikey=\(MarvelAPI.publicKey)&hash=\(hash)&limit=30&orderBy=-modified"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(HeroModel.self, from: data)
        return decodedResponse.data.results
    }

    func getSeries(for heroId: Int) async throws -> [SeriesModel] {
        let ts = String(Int(Date().timeIntervalSince1970))
        let hash = generateHash(ts: ts)
        let urlString = "\(MarvelAPI.baseURL)series?ts=\(ts)&apikey=\(MarvelAPI.publicKey)&hash=\(hash)&characters=\(heroId)&limit=10"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(SerieResponse.self, from: data)
        return decodedResponse.data.results
    }
}

//MD5
private func generateHash(ts: String) -> String {
    let toHash = ts + MarvelAPI.privateKey + MarvelAPI.publicKey
    let digest = Insecure.MD5.hash(data: Data(toHash.utf8))
    return digest.map { String(format: "%02x", $0) }.joined()
}
