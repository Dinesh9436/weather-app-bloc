/// A library containing weather-related events for the Weather BLoC.
///
/// This library defines the events that can be dispatched to the WeatherBloc
/// to trigger state changes.
import 'package:equatable/equatable.dart';

/// Base class for all weather-related events.
///
/// This abstract class ensures all weather events are equatable
/// for proper state comparison and bloc operation.
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch weather data for a specific city.
///
/// This event is dispatched when the user wants to fetch
/// weather information for a particular city.
class FetchWeather extends WeatherEvent {
  /// The name of the city to fetch weather for
  final String city;

  /// Creates a [FetchWeather] event.
  ///
  /// Requires a [city] parameter specifying which city's weather to fetch.
  const FetchWeather({required this.city});

  @override
  List<Object?> get props => [city];
}
