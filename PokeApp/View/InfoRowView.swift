//
//  InfoRowView.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

import SwiftUI

struct InfoRowView: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
    }
}

struct TypeBadge: View {
    let typeName: String
    
    var body: some View {
        Text(typeName.capitalized)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(typeColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
    
    private var typeColor: Color {
        switch typeName.lowercased() {
        case "normal": return .gray
        case "fire": return .red
        case "water": return .blue
        case "electric": return .yellow
        case "grass": return .green
        case "ice": return .cyan
        case "fighting": return .orange
        case "poison": return .purple
        case "ground": return .brown
        case "flying": return .indigo
        case "psychic": return .pink
        case "bug": return Color(red: 0.5, green: 0.7, blue: 0.2)
        case "rock": return Color(red: 0.7, green: 0.5, blue: 0.3)
        case "ghost": return Color(red: 0.4, green: 0.3, blue: 0.7)
        case "dragon": return Color(red: 0.4, green: 0.2, blue: 0.8)
        case "dark": return Color(red: 0.3, green: 0.3, blue: 0.3)
        case "steel": return Color(red: 0.6, green: 0.6, blue: 0.7)
        case "fairy": return Color(red: 1.0, green: 0.7, blue: 0.8)
        default: return .gray
        }
    }
}

struct AbilityBadge: View {
    let ability: PokemonAbility
    
    var body: some View {
        Text(ability.ability.name.capitalized)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(ability.isHidden ? Color.orange.opacity(0.2) : Color.blue.opacity(0.2))
            .foregroundColor(ability.isHidden ? .orange : .blue)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(ability.isHidden ? Color.orange : Color.blue, lineWidth: 1)
            )
    }
}

struct StatBarView: View {
    let stat: PokemonStat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(stat.stat.name.capitalized.replacingOccurrences(of: "-", with: " "))
                    .font(.caption)
                    .fontWeight(.medium)
                    .frame(width: 80, alignment: .leading)
                
                Text("\(stat.baseStat)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .frame(width: 30, alignment: .trailing)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 8)
                    
                    Rectangle()
                        .fill(statColor)
                        .frame(width: CGFloat(stat.baseStat) / 255 * 200, height: 8)
                }
                .clipShape(RoundedRectangle(cornerRadius: 4))
            }
        }
    }
    
    private var statColor: Color {
        let value = stat.baseStat
        switch value {
        case 0..<50: return .red
        case 50..<80: return .orange
        case 80..<110: return .yellow
        case 110..<140: return .green
        default: return .blue
        }
    }
}
