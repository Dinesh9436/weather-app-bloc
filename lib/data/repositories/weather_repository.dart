/// A library for handling weather data retrieval from the OpenWeatherMap API.
///
/// This library provides the repository layer for weather data access and
/// includes error handling specific to weather API operations.
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

/// Custom exception for weather-related errors.
///
/// This exception is thrown when weather API operations fail, providing
/// specific error messages for different types of failures.
class WeatherException implements Exception {
  /// The error message describing what went wrong
  final String message;

  /// Creates a [WeatherException] with a specific error message.
  WeatherException(this.message);

  @override
  String toString() => message;
}

/// Repository responsible for fetching weather data from the OpenWeatherMap API.
///
/// This repository handles:
/// * Making HTTP requests to the weather API
/// * Converting JSON responses to Weather models
/// * Error handling and appropriate error messages
/// * Unit configuration for temperature
class WeatherRepository {
  /// Base URL for the OpenWeatherMap API
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  /// API key for authenticating with OpenWeatherMap
  /// Note: In a production app, this should be stored securely
  static const String _apiKey = 'Your_API_Key_Here';

  /// HTTP client for making API requests
  final http.Client _httpClient;

  /// Creates a [WeatherRepository] instance.
  ///
  /// Optionally accepts a custom [httpClient] for making API requests.
  /// If none is provided, creates a default HTTP client.
  WeatherRepository({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  /// Fetches weather data for a specified city.
  ///
  /// Parameters:
  ///   - [city]: The name of the city to fetch weather for
  ///   - [unit]: The unit system to use ('metric' or 'imperial'), defaults to 'metric'
  ///
  /// Returns a [Future<WeatherModel>] containing the weather data.
  ///
  /// Throws:
  ///   - [WeatherException] with 'City not found' if the city doesn't exist
  ///   - [WeatherException] with 'Invalid API key' if authentication fails
  ///   - [WeatherException] with status code if the API request fails
  ///   - [WeatherException] with network error details for other failures
  Future<WeatherModel> fetchWeather(
    String city, {
    String? unit = 'metric',
  }) async {
    try {
      // Make the API request
      final response = await _httpClient.get(
        Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=$unit'),
      );

      // Handle the response based on status code
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return WeatherModel.fromJson(data);
      } else if (response.statusCode == 404) {
        throw WeatherException('City not found');
      } else if (response.statusCode == 401) {
        throw WeatherException('Invalid API key');
      } else {
        throw WeatherException(
          'Failed to fetch weather data: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Rethrow WeatherExceptions, wrap other errors
      if (e is WeatherException) rethrow;
      throw WeatherException('Network error: $e');
    }
  }

  void dispose() {
    _httpClient.close();
  }
}
