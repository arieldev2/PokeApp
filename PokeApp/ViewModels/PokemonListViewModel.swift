//
//  PokemonListViewModel.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

import SwiftUI

@MainActor
class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [PokemonBasic] = []
    @Published var isLoading = false
    @Published var error: PokemonError?
    @Published var searchText = ""
    
    private let pokemonService: PokemonServiceProtocol
    private var currentOffset = 0
    private let limit = 20
    
    var filteredPokemon: [PokemonBasic] {
        if searchText.isEmpty {
            return pokemonList
        } else {
            return pokemonList.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    init(pokemonService: PokemonServiceProtocol = PokemonService()) {
        self.pokemonService = pokemonService
    }
    
    func loadPokemon() async {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        do {
            let response = try await pokemonService.fetchPokemonList(limit: limit, offset: currentOffset)
            pokemonList.append(contentsOf: response.results)
            currentOffset += limit
        } catch let pokemonError as PokemonError {
            error = pokemonError
        } catch {
            self.error = .networkError
        }
        
        isLoading = false
    }
    
    func refresh() async {
        currentOffset = 0
        pokemonList.removeAll()
        await loadPokemon()
    }
}
