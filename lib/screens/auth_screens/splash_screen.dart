import 'package:dio_clean_architecture/helpers/assets_helper.dart';
import 'package:dio_clean_architecture/helpers/dimesns_helper.dart';
import 'package:dio_clean_architecture/helpers/storage_helper.dart';
import 'package:dio_clean_architecture/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

import 'login_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
   Future.delayed(const Duration(seconds: 3),(){

     debugPrint ('StorageHelper().getUserLat() = > ${StorageHelper().getUserLat()}');
     if(StorageHelper().getUserLat() == 0.0){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LogInScreen()));
     }else{
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
     }

   });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: DimensHelper.dimens_200,
          width: DimensHelper.dimens_200,
          child:  Image.asset(AssetsHelper.weatherIcon),
        ),
      ),
    );
  }
}
