import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:know_weather/api_client/api_client.dart';
import 'package:know_weather/core/errors/exceptions.dart';
import 'package:know_weather/models/weather.dart';

part 'climate_state.dart';

class ClimateCubit extends Cubit<ClimateState> {
  ClimateCubit() : super(ClimateState.initial());

  Future<void> getWeather({required String cityName}) async {
    emit(state.copyWith(weatherStatus: WeatherStatus.loading));

    final result = await ApiClient.fetchCityWeather(cityName: cityName);
    final weatherType = checkWeatherType(weatherID: result.weather[0].id);
    emit(
      state.copyWith(
        climate: result,
        weatherStatus: WeatherStatus.loaded,
        weatherType: weatherType,
      ),
    );
  }

  Future<void> getUserWeather() async {
    emit(state.copyWith(weatherStatus: WeatherStatus.loading));

    try {
      final result = await ApiClient.fetchUserCityWeather();
      final weatherType = checkWeatherType(weatherID: result.weather[0].id);

      emit(
        state.copyWith(
          climate: result,
          weatherStatus: WeatherStatus.loaded,
          weatherType: weatherType,
        ),
      );
    } on LocationDisabledException {
      emit(
        state.copyWith(
          weatherStatus: WeatherStatus.error,
          errorMessage: 'Location Service Not Enabled',
        ),
      );
    } on LocationDeniedException {
      emit(
        state.copyWith(
          weatherStatus: WeatherStatus.error,
          errorMessage: 'Location Permission Denied',
        ),
      );
    }
  }
}

WeatherType checkWeatherType({required int weatherID}){
  if (weatherID >= 200 && weatherID < 300) {
    return WeatherType.thunderstorm;
  } else if (weatherID >= 300 && weatherID < 400) {
    return  WeatherType.drizzle;
  } else if (weatherID >= 500 && weatherID < 600) {
    return  WeatherType.rain;
  } else if (weatherID >= 600 && weatherID < 700) {
    return  WeatherType.snow;
  } else if (weatherID >= 700 && weatherID <= 799) {
    return  WeatherType.atmosphere;
  } else if (weatherID == 800) {
    return  WeatherType.clear;
  } else {
    return  WeatherType.clouds;
  }
}
