//
//  PokemonListRowView.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

import SwiftUI

struct PokemonListRowView: View {
    let pokemon: PokemonBasic
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonId).png")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 60, height: 60)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(pokemon.name.capitalized)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("#\(pokemonId)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
    
    private var pokemonId: Int {
        let components = pokemon.url.components(separatedBy: "/")
        return Int(components[components.count - 2]) ?? 0
    }
}
