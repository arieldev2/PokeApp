//
//  PokemonDetailViewModelTests.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

@testable import PokeApp
import Testing

@Suite("PokemonDetailViewModel Tests")
struct PokemonDetailViewModelTests {
    
    @Test("Load Pokemon Detail Success")
    func loadPokemonDetailSuccess() async throws {
        let mockService = MockPokemonService()
        let viewModel = await PokemonDetailViewModel(pokemonService: mockService)
        
        await viewModel.loadPokemon(name: "pikachu")
        
        let isLoading = await viewModel.isLoading
        let error = await viewModel.error
        let pokemon = await viewModel.pokemon
        
        #expect(!isLoading)
        #expect(error == nil)
        #expect(pokemon != nil)
        #expect(pokemon?.name == "pikachu")
        #expect(pokemon?.id == 25)
    }
    
    @Test("Load Pokemon Detail Failure")
    func loadPokemonDetailFailure() async throws {
        let mockService = MockPokemonService()
        mockService.shouldReturnError = true
        let viewModel = await PokemonDetailViewModel(pokemonService: mockService)
        
        await viewModel.loadPokemon(name: "pikachu")
        
        let isLoading = await viewModel.isLoading
        let error = await viewModel.error
        let pokemon = await viewModel.pokemon
        
        #expect(!isLoading)
        #expect(error != nil)
        #expect(pokemon == nil)
    }
    
    @Test("Load Pokemon with Custom Data")
    func loadPokemonWithCustomData() async throws {
        let mockService = MockPokemonService()
        let customPokemon = Pokemon(
            id: 150,
            name: "mewtwo",
            height: 20,
            weight: 1220,
            types: [
                PokemonType(slot: 1, type: TypeInfo(name: "psychic", url: ""))
            ],
            stats: [
                PokemonStat(baseStat: 106, effort: 0, stat: StatInfo(name: "hp", url: "")),
                PokemonStat(baseStat: 110, effort: 3, stat: StatInfo(name: "attack", url: ""))
            ],
            sprites: PokemonSprites(
                frontDefault: "https://example.com/mewtwo.png",
                frontShiny: "https://example.com/mewtwo-shiny.png",
                other: nil
            ),
            abilities: [
                PokemonAbility(isHidden: false, slot: 1, ability: AbilityInfo(name: "pressure", url: "")),
                PokemonAbility(isHidden: true, slot: 3, ability: AbilityInfo(name: "unnerve", url: ""))
            ]
        )
        mockService.pokemonResponse = customPokemon
        
        let viewModel = await PokemonDetailViewModel(pokemonService: mockService)
        
        await viewModel.loadPokemon(name: "mewtwo")
        
        let pokemon = await viewModel.pokemon
        
        #expect(pokemon?.name == "mewtwo")
        #expect(pokemon?.id == 150)
        #expect(pokemon?.types.count == 1)
        #expect(pokemon?.types.first?.type.name == "psychic")
        #expect(pokemon?.stats.count == 2)
        #expect(pokemon?.abilities.count == 2)
        #expect(pokemon?.abilities.contains { $0.isHidden } == true)
    }
}

