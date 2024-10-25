# Flutter Demo Project

A demonstration Flutter application showcasing asynchronous programming, JSON handling, and state management using BLoC pattern. The app fetches and displays a paginated list of products from the DummyJSON API.

## Features

- Cross-platform support (iOS & Android)
- Asynchronous data fetching
- Infinite scroll pagination
- State management with BLoC pattern
- Network image caching
- REST API integration
- Clean Architecture implementation
- Dependency injection
- Error handling with Result pattern

## Prerequisites

Before running the project, ensure you have the following installed:

- Flutter SDK (>=3.24.3)
- Dart SDK (>=3.5.0)
- Android Studio / XCode for mobile development
- A compatible IDE (VS Code, Android Studio, or IntelliJ)

## Getting Started

### Installation

1. Clone the repository:
```bash
git clone https://github.com/MartinKovachev/demo_app.git
cd demo_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run
```

### Building for Production

For Android:
```bash
flutter build apk --release
```

For iOS:
```bash
flutter build ios --release
```

## Project Structure

The project follows clean architecture principles with the following structure:

```
lib/
├── core/                          # Core functionality and utilities
│   ├── di/                        # Dependency injection setup
│   ├── exception/                 # Custom exceptions
│   ├── network/                   # Network related utilities
│   ├── core_dependencies.dart     # Core layer dependencies
│   ├── logger.dart               # Logging functionality
│   └── result.dart               # Result pattern implementation
│
├── data/                         # Data layer
│   ├── data_model/              # Data transfer objects
│   ├── datasource/              # Remote and local data sources
│   ├── repository/              # Repository implementations
│   └── data_dependencies.dart   # Data layer dependencies
│
├── domain/                      # Domain layer
│   ├── entity/                 # Business entities
│   ├── repository/             # Repository interfaces
│   ├── use_case/              # Business logic use cases
│   └── domain_dependencies.dart # Domain layer dependencies
│
├── presentation/               # Presentation layer
│   ├── common/                # Shared widgets and utilities
│   ├── page/                  # Application pages
│   ├── demo_app.dart          # Application main widget
│   └── presentation_dependencies.dart # Presentation layer dependencies
│
└── main.dart                  # Application entry point
```

## Dependencies

The project uses several key dependencies:

- `cached_network_image`: For efficient image loading and caching
- `dio`: HTTP client for API requests
- `equatable`: Simplifies equality comparisons
- `get_it`: Dependency injection
- `flutter_bloc`: State management
- `infinite_scroll_pagination`: Handles paginated lists
- `provider`: Widget-level state management

For testing:
- `bloc_test`: Testing BLoC components
- `mocktail`: Mocking for tests
- `test`: Dart testing framework

## API Integration

The application integrates with the DummyJSON API:
- Base URL: `https://dummyjson.com`
- Endpoint: `/products`

## Architecture Overview

The project implements clean architecture with four main layers:

1. **Core Layer**
    - Handles cross-cutting concerns
    - Implements dependency injection
    - Manages error handling and logging
    - Provides network utilities

2. **Data Layer**
    - Implements data sources
    - Handles data models and mapping
    - Implements repository pattern

3. **Domain Layer**
    - Contains business entities
    - Defines repository interfaces
    - Implements use cases

4. **Presentation Layer**
    - Manages UI components
    - Handles state management
    - Implements navigation

Each layer has its own dependencies file for better organization and dependency management.

## Usage

1. Launch the application
2. On the products page, tap the "Get Items" button
3. Scroll through the paginated list of products
4. Images are automatically cached for better performance

## Testing

Run tests using:
```bash
flutter test
```