import '../models/auto_complete_places.dart';
import '../models/change_profile.dart';
import '../models/current_weather.dart';
import '../models/login_model.dart';
import '../models/user_profile.dart';
import 'dio_helper.dart';

class Repository {
  static final DioHelper _dioHelper = DioHelper();


  static const String baseUrl = "https://api.escuelajs.co";



  Future<LogInModel> userLogin (Object requestBody) async {
    Map<String, dynamic> response = await _dioHelper.post(url: '$baseUrl/api/v1/auth/login', requestBody: requestBody);
    return LogInModel.fromJson(response);
  }


  Future<AutoCompletePlace> autoCompletePlaces (String placeName) async {
    Map<String, dynamic> response = await _dioHelper.get(url: 'https://geocoding-api.open-meteo.com/v1/search?name=$placeName&count=5');
    return AutoCompletePlace.fromJson(response);
  }


  Future<UserProfileModel> userProfile () async {
    Map<String, dynamic> response = await _dioHelper.get(url: '$baseUrl/api/v1/auth/profile', isAuthRequired: true);
    return UserProfileModel.fromJson(response);
  }

  Future<ChangeProfileModel> changeProfile (Object requestBody) async {
    Map<String, dynamic> response = await _dioHelper.uploadFile(
        url: '$baseUrl/api/v1/files/upload', requestBody: requestBody);
    return ChangeProfileModel.fromJson(response);
  }


  Future<CurrentWeatherModel> currentWeather (String lat, String lng) async {
    Map<String, dynamic> response = await _dioHelper.get(url: 'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lng&current_weather=true');
    return CurrentWeatherModel.fromJson(response);
  }



}
