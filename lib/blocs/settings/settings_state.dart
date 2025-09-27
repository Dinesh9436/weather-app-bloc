/// A library containing settings-related states for the Settings Cubit.
///
/// This library defines all possible states that the settings feature can be in,
/// from initial state to updated settings state.
import 'package:equatable/equatable.dart';

import 'settings_cubit.dart';

/// Base class for all settings-related states.
///
/// This abstract class ensures all settings states are equatable
/// for proper state comparison and bloc operation.
class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

/// Initial state of the settings feature.
///
/// This state is used when the settings haven't been configured yet,
/// typically on first app launch or if no saved settings are found.
class SettingsInitial extends SettingsState {}

/// State representing updated settings configuration.
///
/// This state contains the current settings values that are actively
/// being used by the application.
class SettingsUpdated extends SettingsState {
  /// The currently selected temperature unit
  final TemperatureUnit temperatureUnit;

  /// Creates a [SettingsUpdated] state with the specified temperature unit.
  const SettingsUpdated({required this.temperatureUnit});

  @override
  List<Object?> get props => [temperatureUnit];
}
