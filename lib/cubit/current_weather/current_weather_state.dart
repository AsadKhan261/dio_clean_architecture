part of 'current_weather_cubit.dart';

@immutable
abstract class CurrentWeatherState {}

class CurrentWeatherInitial extends CurrentWeatherState {}

class CurrentWeatherLoading extends CurrentWeatherState {}


class CurrentWeatherLoaded extends CurrentWeatherState {
  final CurrentWeatherModel currentWeatherModel;
  final String address;
  CurrentWeatherLoaded(this.currentWeatherModel, this.address);
}


class CurrentWeatherError extends CurrentWeatherState {}
