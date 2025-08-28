//
//  PokemonListRowView.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

import SwiftUI

struct PokemonListRowView: View {
    let pokemon: PokemonBasic
    @State private var image: UIImage?
    private let imageCache = ImageCache.shared
    
    var body: some View {
        HStack {
            if let image{
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }else{
                SmallPlaceholderView()
            }
            
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
        .onAppear{
            Task{
                image = try await imageCache.image(for: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonId).png")
            }
        }
    }
    
    private var pokemonId: Int {
        let components = pokemon.url.components(separatedBy: "/")
        return Int(components[components.count - 2]) ?? 0
    }
}
