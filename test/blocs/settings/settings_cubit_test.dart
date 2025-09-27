import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:weather_app_studio_session/blocs/settings/settings_cubit.dart';
import 'package:weather_app_studio_session/blocs/settings/settings_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  group('SettingsCubit', () {
    late Storage storage;

    setUp(() {
      storage = MockStorage();
      HydratedBloc.storage = storage;
      when(() => storage.write(any(), any())).thenAnswer((_) async {});
    });

    test('initial state is SettingsInitial', () {
      final cubit = SettingsCubit();
      expect(cubit.state, isA<SettingsInitial>());
      cubit.close();
    });

    blocTest<SettingsCubit, SettingsState>(
      'emits [SettingsUpdated] when temperature unit is updated',
      build: () => SettingsCubit(),
      seed: () => SettingsInitial(),
      act: (cubit) => cubit.updateSettings(unit: TemperatureUnit.fahrenheit),
      expect:
          () => <TypeMatcher<SettingsState>>[
            isA<SettingsUpdated>().having(
              (s) => s.temperatureUnit,
              'temperatureUnit',
              TemperatureUnit.fahrenheit,
            ),
          ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'persists temperature unit when state changes',
      build: () => SettingsCubit(),
      seed: () => SettingsInitial(),
      act: (cubit) => cubit.updateSettings(unit: TemperatureUnit.fahrenheit),
      verify: (cubit) {
        verify(() => storage.write(any(), any())).called(1);
      },
    );
  });
}
