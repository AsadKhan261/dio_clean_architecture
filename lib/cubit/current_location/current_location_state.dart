part of 'current_location_cubit.dart';

@immutable
abstract class CurrentLocationState {}

class CurrentLocationInitial extends CurrentLocationState {}

class CurrentLocationLoading extends CurrentLocationState {}


class CurrentLocationLoaded extends CurrentLocationState {}


class CurrentLocationError extends CurrentLocationState {}
