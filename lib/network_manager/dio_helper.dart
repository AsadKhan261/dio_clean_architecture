import 'package:dio/dio.dart';
import 'package:dio_clean_architecture/helpers/storage_helper.dart';
import 'dart:async';
import 'injection_container.dart';

class DioHelper {
  Dio dio = getDio();

  Options options (bool isAuthRequired){
    if(isAuthRequired){
      return Options(
        receiveDataWhenStatusError: true,
        contentType: "application/json",
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
        headers: {"Authorization": 'Bearer ${StorageHelper().getUserAccessToken()}'},
      );
    }else{
      return Options(
        receiveDataWhenStatusError: true,
        contentType: "application/json",
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
      );
    }
  }



  /// GET API
  Future<dynamic> get ({required String url, bool isAuthRequired = false}) async{
    try {
      Response response = await dio.get(url, options: options(isAuthRequired));
      return response.data;
    }catch (error){
      return null;
    }
  }


  /// POST API
  Future<dynamic> post ({required String url, Object? requestBody, bool isAuthRequired = false}) async{
    try{
      Response response;
      if(requestBody == null){
       response = await dio.post(url, options: options(isAuthRequired));
      }else{
        response = await dio.post(url, data: requestBody, options: options(isAuthRequired));
      }

      return response.data;
    }catch (error){
      return null;
    }
  }


  /// PUT API
  Future<dynamic> put ({required String url, Object? requestBody, bool isAuthRequired = false}) async{

    try{
      Response response;
      if(requestBody == null){
        response = await dio.put(url, options: options(isAuthRequired));
      }else{
        response = await dio.put(url, data: requestBody, options: options(isAuthRequired));
      }

      return response.data;
    }catch (error){
      return null;
    }
  }


  /// PATCH API
  Future<dynamic> patch ({required String url, Object? requestBody, bool isAuthRequired = false}) async{

    try{
      Response response;
      if(requestBody == null){
        response = await dio.patch(url, options: options(isAuthRequired));
      }else{
        response = await dio.patch(url, data: requestBody, options: options(isAuthRequired));
      }

      return response.data;
    }catch (error){
      return null;
    }
  }



  /// DELETE API
  Future<dynamic> delete ({required String url, Object? requestBody, bool isAuthRequired = false}) async{

    try{
      Response response;
      if(requestBody == null){
        response = await dio.delete(url, options: options(isAuthRequired));
      }else{
        response = await dio.delete(url, data: requestBody, options: options(isAuthRequired));
      }

      return response.data;
    }catch (error){
      return null;
    }
  }



  /// MULTIPART API
  Future<dynamic> uploadFile ({required String url, required Object requestBody, bool isAuthRequired = false}) async{
    Options option = Options(headers: {"Content-Type": "multipart/form-data"});

    try{
      Response response = await dio.post(url, data: requestBody, options: option);

      return response.data;
    }catch (error){
      return null;
    }
  }


}