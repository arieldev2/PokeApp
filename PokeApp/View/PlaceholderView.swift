//
//  PlaceholderView.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/28/25.
//

import SwiftUI

struct SmallPlaceholderView: View {
    var body: some View {
        ZStack{
            ProgressView()
            Color.clear
                .frame(width: 60, height: 60)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

struct DetailImagePlaceholderView: View {
    var body: some View {
        ZStack{
            ProgressView()
            Color.clear
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
        }
    }
}
