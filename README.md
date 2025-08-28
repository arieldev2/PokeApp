# 🎯 PokéApp - SwiftUI Pokémon App

> A modern, professional Pokémon reference app built with SwiftUI, featuring MVVM architecture, comprehensive testing, and seamless API integration.

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-iOS%2016.0+-blue.svg)](https://developer.apple.com/swiftui/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://developer.apple.com/ios/)

## 📱 Features

### Core Functionality
- **Complete Pokémon Database** - Browse 1000+ Pokémon with official artwork
- **Infinite Scrolling** - Automatic loading as you scroll through the list
- **Real-time Search** - Find any Pokémon instantly with smart filtering
- **Detailed Information** - Stats, abilities, types, and physical characteristics
- **Offline Caching** - Images cached for optimal performance

### UI/UX Excellence
- **Modern SwiftUI Design** - Clean, intuitive interface
- **Type-specific Colors** - Visual coding for different Pokémon types
- **Responsive Layout** - Works seamlessly on iPhone and iPad
- **Dark Mode Support** - Automatic adaptation to system preferences
- **Pull-to-Refresh** - Easy content updates
- **Loading States** - Smooth animations and progress indicators

## 🏗️ Architecture

### MVVM Pattern
```
Models → ViewModels → Views
    ↓        ↓        ↓
  Data   Business   UI
```

- **Models**: Clean data structures with `Codable` support
- **ViewModels**: `@Observable` classes managing state
- **Views**: SwiftUI components with reactive UI updates
- **Services**: Protocol-based networking and caching layers

### Key Components

```swift
// Service Layer
PokemonServiceProtocol → PokemonService
ImageCacheProtocol → ImageCache

// ViewModels
PokemonListViewModel    // Manages list state and pagination
PokemonDetailViewModel  // Handles individual Pokémon details

// Views
PokemonListView        // Main browsing interface
PokemonDetailView      // Detailed Pokémon information
```

## 🚀 Technical Highlights

### Modern Swift Features
- **Async/Await** - Native asynchronous programming
- **Swift Testing** - Modern testing framework
- **Property Wrappers** - `@State`
- **Observation Framework**  - `@Observable` macro for reactive state management
- **Protocol-Oriented Design** - Dependency injection and testability

### Performance Optimizations
- **Image Caching** - NSCache implementation for smooth scrolling
- **Lazy Loading** - AsyncImage with placeholder states
- **Pagination** - Efficient data loading in batches
- **Memory Management** - Proper resource cleanup

### Error Handling
```swift
enum PokemonError: Error, LocalizedError {
    case networkError
    case decodingError
    case invalidURL
    case pokemonNotFound
}
```

### Dependencies
- **Native SwiftUI** - No external dependencies required
- **PokéAPI** - Free API service (https://pokeapi.co/)

## 🧪 Testing

### Comprehensive Test Suite
```bash
# Run all tests
Cmd + U in Xcode

# Test Coverage Includes:
✅ ViewModel Logic
✅ Network Service Layer
✅ Search Functionality
✅ Error Handling
✅ Mock Data Integration
```

### Test Structure
```swift
@Suite("PokemonListViewModel Tests")
@Suite("PokemonDetailViewModel Tests")  
@Suite("PokemonService Integration Tests")
```

### Mock Implementation
```swift
MockPokemonService: PokemonServiceProtocol
// Enables isolated testing without network calls
```

## 🎨 UI Components

### Custom Views
- **`TypeBadge`** - Color-coded Pokémon type indicators
- **`StatBarView`** - Visual progress bars for base stats  
- **`AbilityBadge`** - Ability indicators with hidden ability styling
- **`PokemonListRowView`** - Optimized list cell design

### Visual Features
- **Official Artwork** - High-quality Pokémon images
- **Progress Bars** - Visual stat representation
- **Color Coding** - Type-specific themes
- **Smooth Animations** - Loading and transition states

## 🌐 API Integration

### PokéAPI Implementation
```swift
Base URL: https://pokeapi.co/api/v2/

Endpoints:
├── /pokemon              # List with pagination
├── /pokemon/{name}       # Individual Pokémon details
└── /pokemon/{id}         # Pokémon by ID
```

### Data Models
- **PokemonListResponse** - Paginated list results
- **Pokemon** - Complete Pokémon details
- **PokemonType, PokemonStat, PokemonAbility** - Supporting data

## 🔧 Configuration

### Network Settings
```swift
// Default pagination
private let limit = 20

// Base URL configuration
private let baseURL = "https://pokeapi.co/api/v2"

// Image caching
private var cache = NSCache<NSString, UIImage>()
```
