//
//  MockImageCache.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/28/25.
//

@testable import PokeApp
import SwiftUI

class MockImageCache: ImageCacheProtocol{
    var shouldReturnError = false

    func image(for url: String) async throws -> UIImage? {
        if shouldReturnError{
            throw PokemonError.invalidURL
        }
        return UIImage(systemName: url)
    }
}
