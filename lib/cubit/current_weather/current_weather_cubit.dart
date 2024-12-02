import 'package:bloc/bloc.dart';
import 'package:dio_clean_architecture/models/current_weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import '../../network_manager/repository.dart';
part 'current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit() : super(CurrentWeatherInitial());



  currentWeather (String lat, String lng) {
    emit(CurrentWeatherLoading());
    Repository().currentWeather(lat, lng).then((currentWeather) async{


      await placemarkFromCoordinates(double.parse(lat), double.parse(lng)).then((value){

        Placemark placeMark  = value[0];
        String name = placeMark.name??"";
        String subLocality = placeMark.subLocality??"";
        String locality = placeMark.locality??"";
        String administrativeArea = placeMark.administrativeArea??"";
        String postalCode = placeMark.postalCode??"";
        String country = placeMark.country??"";
        String address = "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";

        debugPrint(address);

        emit(CurrentWeatherLoaded(currentWeather, locality));
      }).onError((error, stackTrace) {
        emit(CurrentWeatherError());
        debugPrint('ERROR ==> ${error.toString()}');
      });


    }).onError((error, stackTrace) {
      emit(CurrentWeatherError());
      debugPrint('ERROR ==> ${error.toString()}');
    });
  }

}
