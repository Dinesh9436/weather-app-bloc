/// Weather App Studio Session - Main Entry Point
///
/// This application demonstrates the implementation of the BLoC pattern in Flutter,
/// featuring a weather application that shows current weather conditions and allows
/// temperature unit toggling.
///
/// Key Features:
/// * BLoC Pattern Implementation using flutter_bloc
/// * Hydrated BLoC for persistent state
/// * Settings management with Cubit
/// * Weather data fetching and display
/// * Material 3 Design
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app_studio_session/blocs/settings/settings_cubit.dart';
import 'package:weather_app_studio_session/blocs/weather/weather_bloc.dart';
import 'package:weather_app_studio_session/presentation/pages/weather_page.dart';
import 'simple_bloc_observer.dart';

/// Application entry point that initializes necessary configurations and runs the app.
///
/// This function performs the following initializations:
/// 1. Ensures Flutter bindings are initialized
/// 2. Sets up HydratedBloc storage for persistent state
/// 3. Configures BLoC observer for debugging
void main() async {
  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();

  // Configure HydratedBloc storage for persistent state management
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  // Set up BLoC observer for debugging and monitoring bloc events
  Bloc.observer = SimpleBlocObserver();

  // Run the application with Material design and BLoC providers
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: MultiBlocProvider(
        // Set up global BLoC providers for state management
        providers: [
          // Weather BLoC for managing weather data state
          BlocProvider(create: (context) => WeatherBloc()),
          // Settings Cubit for managing app settings state
          BlocProvider(create: (context) => SettingsCubit()),
        ],
        child: const WeatherPage(),
      ),
    ),
  );
}
