//
//  PokemonDetailContentView.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

import SwiftUI

struct PokemonDetailContentView: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Pokémon Image
            HStack {
                Spacer()
                AsyncImage(url: URL(string: pokemon.sprites.other?.officialArtwork?.frontDefault ?? pokemon.sprites.frontDefault ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: 200, height: 200)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 10)
                Spacer()
            }
            
            // Basic Info
            VStack(alignment: .leading, spacing: 12) {
                Text("Basic Info")
                    .font(.title2)
                    .fontWeight(.bold)
                
                InfoRowView(label: "ID", value: "#\(pokemon.id)")
                InfoRowView(label: "Height", value: String(format: "%.1f m", Double(pokemon.height) / 10))
                InfoRowView(label: "Weight", value: String(format: "%.1f kg", Double(pokemon.weight) / 10))
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // Types
            VStack(alignment: .leading, spacing: 12) {
                Text("Types")
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack {
                    ForEach(pokemon.types, id: \.slot) { type in
                        TypeBadge(typeName: type.type.name)
                    }
                    Spacer()
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // Abilities
            VStack(alignment: .leading, spacing: 12) {
                Text("Abilities")
                    .font(.title2)
                    .fontWeight(.bold)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 8) {
                    ForEach(pokemon.abilities, id: \.slot) { ability in
                        AbilityBadge(ability: ability)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // Stats
            VStack(alignment: .leading, spacing: 12) {
                Text("Base Stats")
                    .font(.title2)
                    .fontWeight(.bold)
                
                ForEach(pokemon.stats, id: \.stat.name) { stat in
                    StatBarView(stat: stat)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
