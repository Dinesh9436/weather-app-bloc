/// A library containing weather-related states for the Weather BLoC.
///
/// This library defines all possible states that the weather feature can be in,
/// from initial loading to error states.
import 'package:equatable/equatable.dart';

import '../../data/models/weather_model.dart';

/// Base class for all weather-related states.
///
/// This abstract class ensures all weather states are equatable
/// for proper state comparison and bloc operation.
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

/// Initial state of the weather feature.
///
/// This state is used when the weather feature hasn't fetched any data yet.
class WeatherInitial extends WeatherState {}

/// Loading state while weather data is being fetched.
///
/// This state indicates that a weather API request is in progress.
class WeatherLoading extends WeatherState {}

/// State representing successfully loaded weather data.
///
/// This state contains the actual weather information that can be displayed
/// to the user.
class WeatherLoaded extends WeatherState {
  /// The weather data that was loaded
  final WeatherModel weather;

  /// Creates a [WeatherLoaded] state with the provided weather data.
  const WeatherLoaded({required this.weather});

  @override
  List<Object?> get props => [weather];
}

/// Error state when weather data fetching fails.
///
/// This state contains an error message explaining what went wrong during
/// the weather data fetch operation.
class WeatherError extends WeatherState {
  /// The error message describing what went wrong
  final String message;

  /// Creates a [WeatherError] state with the provided error message.
  const WeatherError({required this.message});

  @override
  List<Object?> get props => [message];
}
