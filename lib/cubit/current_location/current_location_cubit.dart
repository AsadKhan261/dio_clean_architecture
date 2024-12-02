import 'package:bloc/bloc.dart';
import 'package:dio_clean_architecture/helpers/storage_helper.dart';
import 'package:dio_clean_architecture/screens/home_screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../screens/auth_screens/permission_handler.dart';
part 'current_location_state.dart';

class CurrentLocationCubit extends Cubit<CurrentLocationState> {
  CurrentLocationCubit() : super(CurrentLocationInitial());


  getCurrentLocation (BuildContext context, bool isPreviousScreenHome) {
    emit(CurrentLocationLoading());

    determinePosition().then((value) async{
      debugPrint('User Location==> Lat: ${value.latitude} || Lng: ${value.longitude}');





      if(isPreviousScreenHome){
        Map params = {
          'lat': value.latitude,
          'lng': value.longitude};

        Navigator.pop(context, params);

      }else{
        StorageHelper().setUserLat(value.latitude);
        StorageHelper().setUserLng(value.longitude);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
      }

      emit(CurrentLocationLoaded());


    }).onError((error, stackTrace){
      emit(CurrentLocationError());
      debugPrint('ERROR ==> ${error.toString()}');
    });
  }

}
