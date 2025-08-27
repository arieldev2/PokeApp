//
//  PokemonDetailViewModel.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

import SwiftUI

@MainActor
class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    @Published var isLoading = false
    @Published var error: PokemonError?
    
    private let pokemonService: PokemonServiceProtocol
    
    init(pokemonService: PokemonServiceProtocol = PokemonService.shared) {
        self.pokemonService = pokemonService
    }
    
    func loadPokemon(name: String) async {
        isLoading = true
        error = nil
        
        do {
            pokemon = try await pokemonService.fetchPokemon(name: name)
        } catch let pokemonError as PokemonError {
            error = pokemonError
        } catch {
            self.error = .networkError
        }
        
        isLoading = false
    }
}
