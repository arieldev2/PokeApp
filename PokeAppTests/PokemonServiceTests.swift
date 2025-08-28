//
//  PokemonServiceTests.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

@testable import PokeApp
import Testing

@Suite("PokemonService Integration Tests")
struct PokemonServiceTests {
    
    @Test("Pokemon Service Protocol Compliance")
    func pokemonServiceProtocolCompliance() async throws {
        let service: PokemonServiceProtocol = MockPokemonService()
        
        // Test that mock service implements all required methods
        let listResponse = try await service.fetchPokemonList(limit: 1, offset: 0)
        #expect(listResponse.results.count > 0)
        
        let pokemonByName = try await service.fetchPokemon(name: "pikachu")
        #expect(pokemonByName.name == "pikachu")
        
        let pokemonById = try await service.fetchPokemon(id: 25)
        #expect(pokemonById.id == 25)
    }
    
    @Test("Error Handling")
    func errorHandling() async throws {
        let mockService = MockPokemonService()
        mockService.shouldReturnError = true
        
        do {
            _ = try await mockService.fetchPokemonList(limit: 1, offset: 0)
            Issue.record("Expected error to be thrown")
        } catch {
            #expect(error is PokemonError)
        }
        
        do {
            _ = try await mockService.fetchPokemon(name: "pikachu")
            Issue.record("Expected error to be thrown")
        } catch {
            #expect(error is PokemonError)
        }
    }
}
