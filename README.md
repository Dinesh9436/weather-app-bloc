# Weather App with Flutter BLoC

A modern weather application built with Flutter that demonstrates the implementation of the BLoC (Business Logic Component) pattern. This project serves as an educational resource for understanding state management, clean architecture, and best practices in Flutter development.

## Features

- 🌡️ Real-time weather data display
- 🔄 Temperature unit conversion (Celsius/Fahrenheit)
- 🎨 Dynamic weather animations
- 💾 Persistent settings storage
- 🌈 Responsive and adaptive UI
- 🔍 City-based weather search

## Architecture

### BLoC Pattern Implementation

The app follows a clean architecture approach using the BLoC pattern:

```plaintext
lib/
├── blocs/           # Business Logic Components
│   ├── weather/     # Weather-related state management
│   └── settings/    # App settings state management
├── data/
│   ├── models/      # Data models
│   └── repositories/ # Data source abstractions
└── presentation/
    ├── pages/       # Screen layouts
    └── widgets/     # Reusable UI components
```

### Key Components

1. **Weather BLoC**
   - Manages weather data fetching and state
   - Handles loading, success, and error states
   - Implements error handling and retry logic

2. **Settings Cubit**
   - Manages temperature unit preferences
   - Implements HydratedCubit for persistent storage
   - Handles unit conversion logic

3. **Weather Repository**
   - Abstracts OpenWeatherMap API interactions
   - Implements error handling and data transformation
   - Provides clean data models to the BLoC layer

## Technologies Used

- **Flutter**: UI framework
- **flutter_bloc**: State management
- **hydrated_bloc**: Persistent state storage
- **equatable**: Value equality
- **http**: API communication
- **lottie**: Weather animations

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- OpenWeatherMap API key
- Git

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/weather_app_studio_session.git
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Update the API key:
   Navigate to `lib/data/repositories/weather_repository.dart` and replace the API key:

   ```dart
   static const String _apiKey = 'your_api_key_here';
   ```

4. Run the app:

   ```bash
   flutter run
   ```

## Architecture Details

### State Management

1. **Weather States**
   - `WeatherInitial`: Initial state
   - `WeatherLoading`: During API calls
   - `WeatherLoaded`: Successfully fetched data
   - `WeatherError`: Error state with message

2. **Settings States**
   - `SettingsInitial`: Default state
   - `SettingsUpdated`: New temperature unit selected

### Data Flow

```plaintext
User Input → Events → BLoC → Repository → API → Model → State → UI
```

### Error Handling

- Custom `WeatherException` class for specific error cases
- User-friendly error messages via SnackBar
- Graceful fallbacks for network issues

## UI Components

1. **WeatherDisplay**
   - Dynamic weather animations based on conditions
   - Responsive layout with gradient background
   - Unit-aware temperature display
   - Weather condition animations using Lottie

2. **TemperatureUnitToggle**
   - Intuitive unit switching (°C/°F)
   - Persistent selection using HydratedBloc
   - Clean white theme design

3. **Search Field**
   - City name input with white theme
   - Error-aware feedback
   - Responsive to user input

## Best Practices Demonstrated

- Clean Architecture principles
- Separation of concerns
- Dependency injection
- Proper state management
- Error handling
- Code documentation
- Responsive design
- Animation integration
- Persistent storage
- Unit testing support

## Learning Objectives

This project demonstrates several key Flutter development concepts:

1. **State Management**
   - BLoC pattern implementation
   - Event-driven architecture
   - Persistent state handling

2. **UI/UX Design**
   - Responsive layouts
   - Custom animations
   - Theme consistency
   - Error handling UX

3. **API Integration**
   - RESTful API consumption
   - Error handling
   - Data modeling
   - Repository pattern

4. **Best Practices**
   - Clean code architecture
   - Documentation
   - Reusable components
   - Testing preparation

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- OpenWeatherMap API for weather data
- Flutter and Dart team for the amazing framework
- BLoC library maintainers for the excellent state management solution
