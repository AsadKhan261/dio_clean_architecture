import 'package:bloc/bloc.dart';
import 'package:dio_clean_architecture/helpers/storage_helper.dart';
import 'package:dio_clean_architecture/models/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../network_manager/repository.dart';
import '../../screens/auth_screens/location_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());



   userLogin (String email, String password, BuildContext context) {
     emit(LoginLoading());
    Map requestBody =
    {
      "email": email,
      "password": password,
    };

    Repository().userLogin(requestBody).then((value){

      emit(LoginLoaded(value));


      StorageHelper().setUserAccessToken(value.accessToken??"");
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const LocationScreen(isPreviousScreenHome: false,)));


    }).onError((error, stackTrace){
      emit(LoginError());
      debugPrint('ERROR => ${error.toString()}');
    });
  }
}
