//
//  HeroDetailView.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//

import SwiftUI

struct HeroDetailView: View {
    let hero: Hero
    @StateObject var viewModel: HeroDetailViewModel = .init()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Imagen del héroe
                AsyncImage(url: URL(string: hero.thumbnailURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()
                        .cornerRadius(12)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 300)
                        .overlay(ProgressView())
                }
                .padding(.horizontal)
                
                // Nombre del héroe
                Text(hero.name)
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                // Descripción del héroe
                Text(hero.description.isEmpty ? "Sin descripción disponible." : hero.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                // Sección de series
                VStack(alignment: .leading, spacing: 12) {
                    Text("Series (\(viewModel.series.count))")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    if viewModel.isLoading {
                        HStack {
                            ProgressView()
                            Text("Cargando series...")
                        }
                        .padding(.horizontal)
                    }
                    
                    if viewModel.series.isEmpty && !viewModel.isLoading {
                        Text("No se encontraron series para este héroe")
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    } else {
                        ForEach(viewModel.series, id: \.id) { serie in
                            SeriesRowView(series: serie)
                        }
                    }
                }
            }
        }
        .navigationTitle(hero.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchSeries(for: hero.id)
        }
    }
}

#Preview {
    NavigationView {
        HeroDetailView(hero: Hero(
            id: 1011334,
            name: "3-D Man",
            description: "Un héroe con visión tridimensional y fuerza sobrehumana.",
            thumbnail: HeroThumbnail(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/9/10/4ce5a473b81b3",
                extension: "jpg"
            )
        ))
    }
}
