import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../models/change_profile.dart';
import '../../network_manager/repository.dart';

part 'change_profile_state.dart';

class ChangeProfileCubit extends Cubit<ChangeProfileState> {
  ChangeProfileCubit() : super(ChangeProfileInitial());

  changeProfile (File file) async{
    emit(ChangeProfileLoading());

    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({"file": await MultipartFile.fromFile(file.path, filename:fileName),});


    Repository().changeProfile(formData).then((value){

      emit(ChangeProfileLoaded(value));


    }).onError((error, stackTrace){
      emit(ChangeProfileError());
      debugPrint('ERROR => ${error.toString()}');
    });
  }

}
