part of 'auto_complete_places_cubit.dart';

@immutable
abstract class AutoCompletePlacesState {}

class AutoCompletePlacesInitial extends AutoCompletePlacesState {}

class AutoCompletePlacesLoading extends AutoCompletePlacesState {}

class AutoCompletePlacesLoaded extends AutoCompletePlacesState {
  final AutoCompletePlace autoCompletePlace;
  AutoCompletePlacesLoaded(this.autoCompletePlace);
}

class AutoCompletePlacesError extends AutoCompletePlacesState {}
