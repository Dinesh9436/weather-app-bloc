/// Widget library for toggling between temperature units.
///
/// This library provides a user interface component that allows users to
/// switch between Celsius and Fahrenheit temperature units.
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/settings/settings_cubit.dart';
import '../../blocs/settings/settings_state.dart';

/// A widget that provides a toggle between Celsius and Fahrenheit units.
///
/// Features:
/// * Visual toggle buttons for temperature units
/// * Integration with SettingsCubit for state management
/// * Persistent unit selection
/// * Material design styling
class TemperatureUnitToggle extends StatelessWidget {
  /// Creates a [TemperatureUnitToggle] widget.
  const TemperatureUnitToggle({super.key});

  @override
  Widget build(BuildContext context) {
    // Use BlocBuilder to rebuild when settings change
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        // Determine if Celsius is selected, defaulting to true
        final isCelsius =
            state is SettingsUpdated
                ? state.temperatureUnit == TemperatureUnit.celsius
                : true; // Default to Celsius

        return ToggleButtons(
          constraints: const BoxConstraints(minWidth: 45, minHeight: 35),
          borderRadius: BorderRadius.circular(8),
          borderColor: Colors.white.withOpacity(0.6),
          selectedBorderColor: Colors.white,
          selectedColor: Colors.white,
          color: Colors.white.withOpacity(0.7),
          fillColor: Colors.white.withOpacity(0.2),
          isSelected: [isCelsius, !isCelsius],
          onPressed: (index) {
            context.read<SettingsCubit>().updateSettings(
              unit:
                  index == 0
                      ? TemperatureUnit.celsius
                      : TemperatureUnit.fahrenheit,
            );
          },
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '°C',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '°F',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
