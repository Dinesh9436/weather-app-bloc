/// A library for managing application settings with persistence support.
///
/// This library provides the implementation of [SettingsCubit] which handles
/// user preferences and settings, with automatic persistence using HydratedBloc.
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'settings_state.dart';

/// Enumeration of available temperature units.
///
/// Used to toggle between Celsius and Fahrenheit temperature displays.
enum TemperatureUnit { celsius, fahrenheit }

/// A Cubit that manages application settings with persistence support.
///
/// This cubit handles:
/// * Temperature unit preferences (Celsius/Fahrenheit)
/// * Automatic persistence of settings
/// * Loading saved settings on app startup
class SettingsCubit extends HydratedCubit<SettingsState> {
  /// Creates a [SettingsCubit] instance with initial settings.
  SettingsCubit() : super(SettingsInitial());

  /// Updates the application settings with new values.
  ///
  /// Parameters:
  ///   - [unit]: The new temperature unit to use (Celsius/Fahrenheit)
  void updateSettings({required TemperatureUnit unit}) {
    emit(SettingsUpdated(temperatureUnit: unit));
  }

  /// Deserializes JSON into a [SettingsState].
  ///
  /// This method is called by HydratedBloc when loading persisted settings.
  /// Returns a [SettingsState] based on the stored JSON data.
  ///
  /// Falls back to [SettingsInitial] if deserialization fails.
  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    try {
      // Try to parse the temperature unit from JSON
      final temperatureUnit = TemperatureUnit.values.firstWhere(
        (e) => e.toString() == json['temperatureUnit'],
        orElse: () => TemperatureUnit.celsius, // Default to Celsius
      );
      return SettingsUpdated(temperatureUnit: temperatureUnit);
    } catch (_) {
      return SettingsInitial();
    }
  }

  /// Serializes the current [SettingsState] to JSON for persistence.
  ///
  /// This method is called by HydratedBloc when saving settings.
  /// Returns a JSON map for [SettingsUpdated] state, null for other states.
  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    if (state is SettingsUpdated) {
      return {'temperatureUnit': state.temperatureUnit.toString()};
    }
    return null;
  }
}
