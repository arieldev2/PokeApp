//
//  PokemonError.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

import Foundation

// MARK: - Errors
enum PokemonError: Error, LocalizedError {
    case networkError
    case decodingError
    case invalidURL
    case pokemonNotFound
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Network connection failed"
        case .decodingError:
            return "Failed to decode response"
        case .invalidURL:
            return "Invalid URL"
        case .pokemonNotFound:
            return "Pokémon not found"
        }
    }
}
