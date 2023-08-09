part of 'climate_cubit.dart';

enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

enum WeatherType {
  thunderstorm,
  drizzle,
  rain,
  snow,
  atmosphere,
  clear,
  clouds,
}

class ClimateState extends Equatable {
  final WeatherStatus weatherStatus;
  final WeatherType weatherType;
  final Climate climate;
  final String errorMessage;

  const ClimateState({
    required this.weatherStatus,
    required this.climate,
    required this.errorMessage,
    required this.weatherType,
  });

  factory ClimateState.initial() {
    return ClimateState(
      weatherStatus: WeatherStatus.initial,
      climate: Climate.initial(),
      errorMessage: '',
      weatherType: WeatherType.thunderstorm,
    );
  }

  @override
  List<Object> get props => [
        weatherStatus,
        climate,
        errorMessage,
    weatherType,
      ];

  ClimateState copyWith({
    WeatherStatus? weatherStatus,
    WeatherType? weatherType,
    Climate? climate,
    String? errorMessage,
  }) {
    return ClimateState(
      weatherStatus: weatherStatus ?? this.weatherStatus,
      weatherType: weatherType ?? this.weatherType,
      climate: climate ?? this.climate,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
