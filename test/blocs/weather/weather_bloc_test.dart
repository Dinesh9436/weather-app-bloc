import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_studio_session/blocs/weather/weather_bloc.dart';
import 'package:weather_app_studio_session/blocs/weather/weather_event.dart';
import 'package:weather_app_studio_session/blocs/weather/weather_state.dart';
import 'package:weather_app_studio_session/data/models/weather_model.dart';
import 'package:weather_app_studio_session/data/repositories/weather_repository.dart';

class MockWeatherModel extends Mock implements WeatherModel {}

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late MockWeatherModel mockWeatherModel;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherModel = MockWeatherModel();
    mockWeatherRepository = MockWeatherRepository();

    // Setup mock weather model
    when(() => mockWeatherModel.cityName).thenReturn('London');
    when(() => mockWeatherModel.temperature).thenReturn(20.0);
    when(() => mockWeatherModel.feelsLike).thenReturn(19.0);
    when(() => mockWeatherModel.humidity).thenReturn(70);
    when(() => mockWeatherModel.description).thenReturn('cloudy');
    when(() => mockWeatherModel.iconCode).thenReturn('04d');
    when(() => mockWeatherModel.windSpeed).thenReturn(5.0);
    when(() => mockWeatherModel.pressure).thenReturn(1013);

    // Setup mock repository
    when(
      () => mockWeatherRepository.fetchWeather('London'),
    ).thenAnswer((_) async => mockWeatherModel);
    when(
      () => mockWeatherRepository.fetchWeather('InvalidCity'),
    ).thenThrow(Exception('Failed to fetch weather data'));
  });

  group('WeatherBloc', () {
    const city = 'London';

    test('initial state is WeatherInitial', () {
      final bloc = WeatherBloc(repository: mockWeatherRepository);
      expect(bloc.state, isA<WeatherInitial>());
      bloc.close();
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when FetchWeather succeeds',
      build: () => WeatherBloc(repository: mockWeatherRepository),
      act: (bloc) => bloc.add(FetchWeather(city: city)),
      expect:
          () => [
            isA<WeatherLoading>(),
            isA<WeatherLoaded>().having(
              (state) => state.weather,
              'weather',
              equals(mockWeatherModel),
            ),
          ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherError] when FetchWeather fails',
      build: () => WeatherBloc(repository: mockWeatherRepository),
      act: (bloc) => bloc.add(FetchWeather(city: 'InvalidCity')),
      expect:
          () => [
            isA<WeatherLoading>(),
            isA<WeatherError>().having(
              (state) => state.message,
              'error message',
              contains('Failed to fetch weather data'),
            ),
          ],
    );
  });
}
