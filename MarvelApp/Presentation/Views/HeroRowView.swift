//
//  HeroRowView.swift
//  MarvelApp
//
//  Created by Javier Gomez on 14/6/25.
//


import SwiftUI

struct HeroRowView: View {
    let hero: Hero

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: hero.thumbnailURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } placeholder: {
                ProgressView()
            }

            Text(hero.name)
                .font(.title)
                .bold()
                .padding(.bottom, 4)

            

            Spacer()
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    HeroRowView(hero: Hero(
        id: 1,
        name: "Iron Man",
        description: "Genio, millonario, playboy, filántropo.",
        thumbnail: HeroThumbnail(
            path: "https://i.annihil.us/u/prod/marvel/i/mg/9/10/4ce5a473b81b3",
            extension: "jpg"
        )
    ))
}
