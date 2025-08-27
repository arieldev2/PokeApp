//
//  PokemonDetailView.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemonName: String
    @State private var viewModel = PokemonDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.isLoading {
                    ProgressView("Loading \(pokemonName.capitalized)...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 100)
                } else if let pokemon = viewModel.pokemon {
                    PokemonDetailContentView(pokemon: pokemon)
                } else if viewModel.error != nil {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                        Text("Failed to load Pokémon")
                            .font(.headline)
                        Text(viewModel.error?.localizedDescription ?? "Unknown error")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Button("Retry") {
                            Task {
                                await viewModel.loadPokemon(name: pokemonName)
                            }
                        }
                        .padding(.top)
                    }
                    .padding(.top, 100)
                }
            }
            .padding()
        }
        .navigationTitle(pokemonName.capitalized)
        .navigationBarTitleDisplayMode(.large)
        .task {
            await viewModel.loadPokemon(name: pokemonName)
        }
    }
}
