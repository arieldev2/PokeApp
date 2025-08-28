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
    var returnCachedimage = false
    var returnServerImage = false

    func image(for url: String) async throws -> UIImage? {
        if shouldReturnError{
            throw PokemonError.invalidURL
        }
        if returnCachedimage{
            return UIImage(systemName: url)
        }
        if returnServerImage{
            return UIImage(systemName: url)
        }
        return UIImage(systemName: url)
    }
}
