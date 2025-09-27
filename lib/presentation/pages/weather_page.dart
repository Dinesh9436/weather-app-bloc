/// Main weather display page of the application.
///
/// This page demonstrates:
/// * Integration with Weather BLoC for state management
/// * User input handling for city search
/// * Error handling and display
/// * Responsive weather information display
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_studio_session/presentation/widgets/weather_display.dart';
import 'package:weather_app_studio_session/presentation/widgets/temperature_unit_toggle.dart';

import '../../blocs/weather/weather_bloc.dart';
import '../../blocs/weather/weather_event.dart'; // For GetWeather event
import '../../blocs/weather/weather_state.dart'; // For WeatherState

/// The main page widget that displays weather information and handles user input.
///
/// Features:
/// * City search input field
/// * Temperature unit toggle
/// * Weather information display
/// * Loading and error state handling
class WeatherPage extends StatelessWidget {
  /// Creates a [WeatherPage] widget.
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WEATHER APP',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        // Add temperature unit toggle in the app bar
        actions: const [Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: TemperatureUnitToggle(),
        )],
      ),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.2),
              Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // City search input field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter city name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                cursorColor: Colors.white,
                // When user submits a city name, dispatch FetchWeather event
                onSubmitted: (cityName) {
                  context.read<WeatherBloc>().add(FetchWeather(city: cityName));
                },
              ),
              const SizedBox(height: 16.0),
              // Weather state management with BlocConsumer
              BlocConsumer<WeatherBloc, WeatherState>(
                listener: (context, state) {
                  if (state is WeatherError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message.isNotEmpty
                              ? state.message
                              : 'An error occurred',
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is WeatherLoaded) {
                    return WeatherDisplay(weather: state.weather);
                  } else {
                    return const Text('Enter a city to get the weather');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
