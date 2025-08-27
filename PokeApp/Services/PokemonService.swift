//
//  PokemonService.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

import SwiftUI

// MARK: - Protocols
protocol PokemonServiceProtocol {
    func fetchPokemonList(limit: Int, offset: Int) async throws -> PokemonListResponse
    func fetchPokemon(name: String) async throws -> Pokemon
    func fetchPokemon(id: Int) async throws -> Pokemon
}


// MARK: - Services
class PokemonService: PokemonServiceProtocol {
    private let baseURL = "https://pokeapi.co/api/v2"
    private let session = URLSession.shared
    
    func fetchPokemonList(limit: Int = 20, offset: Int = 0) async throws -> PokemonListResponse {
        let url = URL(string: "\(baseURL)/pokemon?limit=\(limit)&offset=\(offset)")!
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw PokemonError.networkError
        }
        
        do {
            return try JSONDecoder().decode(PokemonListResponse.self, from: data)
        } catch {
            throw PokemonError.decodingError
        }
    }
    
    func fetchPokemon(name: String) async throws -> Pokemon {
        let url = URL(string: "\(baseURL)/pokemon/\(name.lowercased())")!
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw PokemonError.networkError
        }
        
        do {
            return try JSONDecoder().decode(Pokemon.self, from: data)
        } catch {
            throw PokemonError.decodingError
        }
    }
    
    func fetchPokemon(id: Int) async throws -> Pokemon {
        let url = URL(string: "\(baseURL)/pokemon/\(id)")!
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw PokemonError.networkError
        }
        
        do {
            return try JSONDecoder().decode(Pokemon.self, from: data)
        } catch {
            throw PokemonError.decodingError
        }
    }
}
