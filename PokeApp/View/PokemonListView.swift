//
//  PokemonListView.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

import SwiftUI

struct PokemonListView: View {
    @State private var viewModel = PokemonListViewModel()
    
    private let imageCache = ImageCache.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading && viewModel.pokemonList.isEmpty {
                    ProgressView("Loading Pokémon...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(viewModel.filteredPokemon) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemonName: pokemon.name)) {
                                PokemonListRowView(pokemon: pokemon)
                            }
                            .onAppear {
                                // Load more when approaching the end of the list
                                if pokemon.id == viewModel.filteredPokemon.last?.id && !viewModel.isLoading && viewModel.searchText.isEmpty {
                                    Task {
                                        await viewModel.loadPokemon()
                                    }
                                }
                            }
                        }
                        
                        if viewModel.isLoading {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.refresh()
                    }
                }
            }
            .navigationTitle("Pokédex")
            .searchable(text: $viewModel.searchText, prompt: "Search Pokémon")
            .alert("Error", isPresented: .constant(viewModel.error != nil)) {
                Button("OK") {
                    viewModel.error = nil
                }
            } message: {
                Text(viewModel.error?.localizedDescription ?? "Unknown error")
            }
        }
        .task {
            if viewModel.pokemonList.isEmpty {
                await viewModel.loadPokemon()
            }
        }
    }
}
