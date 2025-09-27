/// Widget library for displaying weather information with animations.
///
/// This library provides a visually appealing way to display weather data
/// with appropriate weather animations and temperature unit conversion support.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../blocs/settings/settings_cubit.dart';
import '../../blocs/settings/settings_state.dart';
import '../../data/models/weather_model.dart';

/// A widget that displays weather information with animations.
///
/// Features:
/// * Dynamic weather animations based on conditions
/// * Temperature display with unit conversion
/// * Gradient background for visual appeal
/// * Weather condition details
class WeatherDisplay extends StatelessWidget {
  /// The weather data to display
  final WeatherModel weather;

  /// Creates a [WeatherDisplay] widget.
  ///
  /// Requires a [weather] model containing the weather information to display.
  const WeatherDisplay({super.key, required this.weather});

  /// Determines which animation to show based on weather conditions.
  ///
  /// Maps the weather description to appropriate Lottie animation assets:
  /// * Rain conditions show rain animation
  /// * Snow conditions show snow animation
  /// * Cloudy conditions show cloud animation
  /// * Clear conditions show sun animation
  /// * Default weather animation for other conditions
  ///
  /// Returns the path to the appropriate animation asset.
  String _getWeatherAnimation() {
    // Map weather conditions to Lottie animation assets
    final condition = weather.description.toLowerCase();
    if (condition.contains('rain')) {
      return 'assets/animations/Rainy.json';
    } else if (condition.contains('snow')) {
      return 'assets/animations/Snow.json';
    } else if (condition.contains('cloud')) {
      return 'assets/animations/Clouds.json';
    } else if (condition.contains('clear')) {
      return 'assets/animations/Sunny.json';
    }
    return 'assets/animations/default_weather.json';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
            Theme.of(context).colorScheme.secondary.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // City Name and Temperature Section
          _buildHeaderSection(),

          // Weather Animation
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: LottieBuilder.asset(
              _getWeatherAnimation(),
              height: 200,
              width: 200,
            ),
          ),

          // Weather Details Cards
          _buildWeatherDetailsCards(context),
        ],
      ),
    );
  }

  double _convertTemperature(double celsius, TemperatureUnit unit) {
    return unit == TemperatureUnit.celsius ? celsius : (celsius * 9 / 5) + 32;
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Text(
            weather.cityName,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              final unit =
                  state is SettingsUpdated
                      ? state.temperatureUnit
                      : TemperatureUnit.celsius;
              final temperature = _convertTemperature(
                weather.temperature,
                unit,
              );

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${temperature.round()}',
                    style: const TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    unit == TemperatureUnit.celsius ? '°C' : '°F',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ],
              );
            },
          ),
          Text(
            weather.description.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetailsCards(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  final unit =
                      state is SettingsUpdated
                          ? state.temperatureUnit
                          : TemperatureUnit.celsius;
                  final feelsLike = _convertTemperature(
                    weather.feelsLike,
                    unit,
                  );
                  return _buildDetailCard(
                    context,
                    'Feels Like',
                    '${feelsLike.round()}${unit == TemperatureUnit.celsius ? '°C' : '°F'}',
                    Icons.thermostat,
                  );
                },
              ),
              _buildDetailCard(
                context,
                'Humidity',
                '${weather.humidity}%',
                Icons.water_drop,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildDetailCard(
                context,
                'Wind Speed',
                '${weather.windSpeed} m/s',
                Icons.air,
              ),
              _buildDetailCard(
                context,
                'Pressure',
                '${weather.pressure} hPa',
                Icons.speed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: Colors.white70, size: 24),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
