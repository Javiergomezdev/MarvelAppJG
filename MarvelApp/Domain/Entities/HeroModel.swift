//
//  HeroResponse.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//


import Foundation

struct HeroModel: Codable {
    let data: HeroDataContainer
}

struct HeroDataContainer: Codable {
    let results: [Hero]
}

struct Hero: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: HeroThumbnail

    
   var thumbnailURL: String {
        let securePath = thumbnail.path.starts(with: "http") ? thumbnail.path : "https://\(thumbnail.path)"
        return "\(securePath).\(thumbnail.extension)"
    }
}

struct HeroThumbnail: Codable, Hashable{
    let path: String
    let `extension`: String
}


//"thumbnail": {
//"path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
//"extension": "jpg"
