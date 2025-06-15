//
//  HeroListView.swift
//  MarvelApp
//
//  Created by Javier Gomez on 12/6/25.
//

import SwiftUI

struct HeroListView: View {
    @StateObject private var viewModel = HeroListViewModel()
    @State private var selectedHero: Hero? = nil

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Cargando héroes...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 22) {
                            ForEach(viewModel.heroes) { hero in
                                                            NavigationLink(value: hero) {
                                                                HeroRowView(hero: hero)
                                                            }
                                                            .buttonStyle(PlainButtonStyle())
                                                            .scrollTransition(axis: .vertical) { content, phase in
                                                                content
                                                                    .rotation3DEffect(.degrees(phase.value * 30), axis: (x: 0, y: 1, z: 0))
                                                                    .offset(y: phase.isIdentity ? 0 : 15)
                                                            }
                            }
                        }
                        .padding()
                    }
                    .refreshable {
                        await viewModel.fetchHeroes()
                    }
                }
            }
            .navigationTitle("Héroes")
            .navigationDestination(for: Hero.self) { hero in
            HeroDetailView(hero: hero)
            }
        }
        .task {
                    await viewModel.fetchHeroes()
                }
            }
        }
    
    


#Preview {
    HeroListView()
}
