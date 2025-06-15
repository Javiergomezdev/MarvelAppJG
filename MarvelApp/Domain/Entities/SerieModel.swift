//
//  Serie.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//
struct SerieResponse: Codable {
    let data: SerieDataContainer
}
struct SerieDataContainer: Codable {
    let results: [SeriesModel]
}

struct SeriesModel: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let description: String
    let thumbnail: SeriesThumbnail
    
    var thumbnailURL: String {
         let securePath = thumbnail.path.starts(with: "http") ? thumbnail.path : "https://\(thumbnail.path)"
         return "\(securePath).\(thumbnail.extension)"
     }
}

struct SeriesThumbnail: Codable, Hashable{
    let path: String
    let `extension`: String
}
