/// A library for managing weather-related state in the application.
///
/// This library provides the implementation of [WeatherBloc] which handles
/// weather data fetching and state management using the BLoC pattern.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_studio_session/data/models/weather_model.dart';
import 'package:weather_app_studio_session/data/repositories/weather_repository.dart';
import 'weather_event.dart';
import 'weather_state.dart';

/// A BLoC that manages weather-related state in the application.
///
/// This BLoC handles:
/// * Fetching weather data for a specific city
/// * Managing loading states during API calls
/// * Handling success and error states
/// * Maintaining the current weather data
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  /// Repository responsible for making weather API calls
  final WeatherRepository weatherRepository;

  /// Creates a [WeatherBloc] instance.
  ///
  /// Takes an optional [repository] parameter for weather data fetching.
  /// If no repository is provided, creates a default [WeatherRepository] instance.
  WeatherBloc({WeatherRepository? repository})
    : weatherRepository = repository ?? WeatherRepository(),
      super(WeatherInitial()) {
    // Register event handler for FetchWeather event
    on<FetchWeather>((event, emit) async {
      // Emit loading state immediately when fetch begins
      emit(WeatherLoading());
      try {
        // Attempt to fetch weather data
        final weather = await fetchWeather(event.city);
        // Emit success state with weather data
        emit(WeatherLoaded(weather: weather));
      } catch (e) {
        // Emit error state if fetch fails
        emit(WeatherError(message: e.toString()));
      }
    });
  }

  /// Fetches weather data for a specified city.
  ///
  /// Parameters:
  ///   - [city]: The name of the city to fetch weather for
  ///
  /// Returns a [Future<WeatherModel>] containing the weather data.
  /// Throws an exception if the fetch operation fails.
  Future<WeatherModel> fetchWeather(String city) async {
    try {
      return await weatherRepository.fetchWeather(city);
    } catch (e) {
      throw Exception("Failed to fetch weather data");
    }
  }
}
