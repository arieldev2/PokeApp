//
//  MockPokemonService.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

@testable import PokeApp
import SwiftUI

class MockPokemonService: PokemonServiceProtocol {
    var shouldReturnError = false
    var pokemonListResponse: PokemonListResponse?
    var pokemonResponse: Pokemon?
    
    func fetchPokemonList(limit: Int, offset: Int) async throws -> PokemonListResponse {
        if shouldReturnError {
            throw PokemonError.networkError
        }
        
        return pokemonListResponse ?? PokemonListResponse(
            count: 1,
            next: nil,
            previous: nil,
            results: [PokemonBasic(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/")]
        )
    }
    
    func fetchPokemon(name: String) async throws -> Pokemon {
        if shouldReturnError {
            throw PokemonError.networkError
        }
        
        return pokemonResponse ?? createMockPokemon()
    }
    
    func fetchPokemon(id: Int) async throws -> Pokemon {
        if shouldReturnError {
            throw PokemonError.networkError
        }
        
        return pokemonResponse ?? createMockPokemon()
    }
    
    private func createMockPokemon() -> Pokemon {
        return Pokemon(
            id: 25,
            name: "pikachu",
            height: 4,
            weight: 60,
            types: [PokemonType(slot: 1, type: TypeInfo(name: "electric", url: ""))],
            stats: [PokemonStat(baseStat: 55, effort: 0, stat: StatInfo(name: "hp", url: ""))],
            sprites: PokemonSprites(frontDefault: "test-url", frontShiny: nil, other: nil),
            abilities: [PokemonAbility(isHidden: false, slot: 1, ability: AbilityInfo(name: "static", url: ""))]
        )
    }
}
