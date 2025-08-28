//
//  ImageCacheTests.swift
//  PokeApp
//
//  Created by Ariel Ortiz on 8/28/25.
//

@testable import PokeApp
import Testing

@Suite("ImageCache Integration Tests")
struct ImageCacheTests{
    
    @Test("ImageCache Service Protocol Compliance")
    func imageCacheServiceProtocolCompliance() async throws {
        let service: ImageCacheProtocol = MockImageCache()
        
        // Test that mock service implements all required methods
        let imageResponse = try await service.image(for: "person")
        #expect(imageResponse != nil)
    }
    
    @Test("Error Handling")
    func errorHandling() async throws {
        let mockService = MockImageCache()
        mockService.shouldReturnError = true
        
        do {
            _ = try await mockService.image(for: "cat")
            Issue.record("Expected error to be thrown")
        } catch {
            #expect(error is PokemonError)
        }
        
        do {
            _ = try await mockService.image(for: "dog")
            Issue.record("Expected error to be thrown")
        } catch {
            #expect(error is PokemonError)
        }
    }
}
