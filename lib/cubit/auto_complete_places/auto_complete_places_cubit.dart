import 'package:bloc/bloc.dart';
import 'package:dio_clean_architecture/network_manager/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../models/auto_complete_places.dart';

part 'auto_complete_places_state.dart';

class AutoCompletePlacesCubit extends Cubit<AutoCompletePlacesState> {
  AutoCompletePlacesCubit() : super(AutoCompletePlacesInitial());



  autoCompletePlaces (String placeName) {
    emit(AutoCompletePlacesLoading());

    Repository().autoCompletePlaces(placeName).then((value){

      emit(AutoCompletePlacesLoaded(value));

    }).onError((error, stackTrace) {
      emit(AutoCompletePlacesError());
      debugPrint('ERROR ==> ${error.toString()}');
    });
  }

}
