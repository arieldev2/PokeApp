//
//  ImageCache.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/27/25.
//

import SwiftUI

protocol ImageCacheProtocol {
    func image(for url: String) async throws -> UIImage?
    func setImage(_ image: UIImage, for url: String)
}


class ImageCache: ImageCacheProtocol {
    private var cache = NSCache<NSString, UIImage>()
    
    func image(for url: String) async throws -> UIImage? {
        if let cachedImage = cache.object(forKey: url as NSString) {
            return cachedImage
        }
        
        guard let imageURL = URL(string: url) else {
            throw PokemonError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: imageURL)
        
        if let image = UIImage(data: data) {
            cache.setObject(image, forKey: url as NSString)
            return image
        }
        
        return nil
    }
    
    func setImage(_ image: UIImage, for url: String) {
        cache.setObject(image, forKey: url as NSString)
    }
}
