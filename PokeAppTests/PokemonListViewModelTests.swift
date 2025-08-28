//
//  PokemonListViewModelTests.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

@testable import PokeApp
import Testing

@Suite("PokemonListViewModel Tests")
struct PokemonListViewModelTests {
    
    @Test("Load Pokemon Success")
    func loadPokemonSuccess() async throws {
        let mockService = MockPokemonService()
        let viewModel = await PokemonListViewModel(pokemonService: mockService)
        
        await viewModel.loadPokemon()
        
        let isLoading = await viewModel.isLoading
        let error = await viewModel.error
        let pokemonList = await viewModel.pokemonList
        
        #expect(!isLoading)
        #expect(error == nil)
        #expect(pokemonList.count == 1)
        #expect(pokemonList.first?.name == "pikachu")
    }
    
    @Test("Load Pokemon Failure")
    func loadPokemonFailure() async throws {
        let mockService = MockPokemonService()
        mockService.shouldReturnError = true
        let viewModel = await PokemonListViewModel(pokemonService: mockService)
        
        await viewModel.loadPokemon()
        
        let isLoading = await viewModel.isLoading
        let error = await viewModel.error
        let pokemonList = await viewModel.pokemonList
        
        #expect(!isLoading)
        #expect(error != nil)
        #expect(pokemonList.count == 0)
    }
    
    @Test("Filtered Pokemon Search")
    func filteredPokemonSearch() async throws {
        let mockService = MockPokemonService()
        let viewModel = await PokemonListViewModel(pokemonService: mockService)
        
        await MainActor.run {
            viewModel.pokemonList = [
                PokemonBasic(name: "pikachu", url: ""),
                PokemonBasic(name: "charizard", url: "")
            ]
        }
        
        // Test search functionality
        await MainActor.run {
            viewModel.searchText = "pika"
        }
        
        let filteredPokemon = await viewModel.filteredPokemon
        #expect(filteredPokemon.count == 1)
        #expect(filteredPokemon.first?.name == "pikachu")
        
        // Test empty search
        await MainActor.run {
            viewModel.searchText = ""
        }
        
        let allPokemon = await viewModel.filteredPokemon
        #expect(allPokemon.count == 2)
    }
    
    @Test("Multiple Pokemon Loading")
    func multiplePokemonLoading() async throws {
        let mockService = MockPokemonService()
        mockService.pokemonListResponse = PokemonListResponse(
            count: 3,
            next: "next-url",
            previous: nil,
            results: [
                PokemonBasic(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/"),
                PokemonBasic(name: "charizard", url: "https://pokeapi.co/api/v2/pokemon/6/"),
                PokemonBasic(name: "blastoise", url: "https://pokeapi.co/api/v2/pokemon/9/")
            ]
        )
        
        let viewModel = await PokemonListViewModel(pokemonService: mockService)
        
        await viewModel.loadPokemon()
        
        let pokemonList = await viewModel.pokemonList
        #expect(pokemonList.count == 3)
        #expect(pokemonList.contains { $0.name == "pikachu" })
        #expect(pokemonList.contains { $0.name == "charizard" })
        #expect(pokemonList.contains { $0.name == "blastoise" })
    }
}
