/// A data model library for weather information.
///
/// This library provides the [WeatherModel] class which represents
/// weather data received from the OpenWeatherMap API.
import 'package:equatable/equatable.dart';

/// A model class that represents weather information for a city.
///
/// This class encapsulates various weather attributes including:
/// * Basic information (city name, temperature)
/// * Atmospheric conditions (humidity, pressure)
/// * Weather description and icon
/// * Wind information
///
/// The class implements [Equatable] for proper value comparison
/// and includes JSON serialization support.
class WeatherModel extends Equatable {
  /// The name of the city this weather data represents
  final String cityName;

  /// The current temperature in the configured unit (Celsius/Fahrenheit)
  final double temperature;

  /// The "feels like" temperature, accounting for humidity and wind
  final double feelsLike;

  /// The relative humidity percentage (0-100)
  final int humidity;

  /// A text description of the weather conditions
  final String description;

  /// The weather icon code from OpenWeatherMap
  final String iconCode;

  /// The wind speed in meters per second
  final double windSpeed;

  /// The atmospheric pressure in hPa (hectopascals)
  final int pressure;

  /// Creates a [WeatherModel] instance.
  ///
  /// All parameters are required to ensure complete weather information:
  /// * [cityName]: Name of the city
  /// * [temperature]: Current temperature
  /// * [feelsLike]: Perceived temperature
  /// * [humidity]: Relative humidity percentage
  /// * [description]: Weather condition description
  /// * [iconCode]: Weather icon identifier
  /// * [windSpeed]: Current wind speed
  /// * [pressure]: Atmospheric pressure
  const WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.description,
    required this.iconCode,
    required this.windSpeed,
    required this.pressure,
  });

  /// Creates a [WeatherModel] from JSON data.
  ///
  /// This factory constructor converts OpenWeatherMap API JSON response
  /// into a [WeatherModel] instance. It handles the nested structure
  /// of the API response and ensures proper type conversion.
  ///
  /// The JSON structure should match the OpenWeatherMap API format:
  /// ```json
  /// {
  ///   "name": "City",
  ///   "main": {
  ///     "temp": 20.5,
  ///     "feels_like": 21.0,
  ///     "humidity": 65,
  ///     "pressure": 1013
  ///   },
  ///   "weather": [{
  ///     "description": "clear sky",
  ///     "icon": "01d"
  ///   }],
  ///   "wind": {
  ///     "speed": 3.6
  ///   }
  /// }
  /// ```
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'],
      description: weather['description'],
      iconCode: weather['icon'],
      windSpeed: json['wind']['speed'].toDouble(),
      pressure: json['main']['pressure'],
    );
  }

  /// Converts this [WeatherModel] instance to a JSON map.
  ///
  /// This method creates a JSON structure that matches the
  /// OpenWeatherMap API format, making it suitable for storage
  /// or transmission.
  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'main': {
        'temp': temperature,
        'feels_like': feelsLike,
        'humidity': humidity,
      },
      'weather': [
        {'description': description, 'icon': iconCode},
      ],
      'wind': {'speed': windSpeed},
    };
  }

  @override
  List<Object> get props => [
    cityName,
    temperature,
    feelsLike,
    humidity,
    description,
    iconCode,
    windSpeed,
  ];
}
