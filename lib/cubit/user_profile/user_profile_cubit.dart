import 'package:bloc/bloc.dart';
import 'package:dio_clean_architecture/helpers/storage_helper.dart';
import 'package:dio_clean_architecture/network_manager/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../models/user_profile.dart';
part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());


  userProfile () {
    emit(UserProfileLoading());
    Repository().userProfile().then((value) {

      if(StorageHelper().getProfileImage() == ""){
        StorageHelper().setProfileImage(value.avatar??"");
      }

      emit(UserProfileLoaded(value));
    }).onError((error, stackTrace) {
      emit(UserProfileError());
      debugPrint('ERROR ==> ${error.toString()}');
    });
  }
}
