import 'package:dio_clean_architecture/helpers/assets_helper.dart';
import 'package:dio_clean_architecture/helpers/colors_helper.dart';
import 'package:dio_clean_architecture/helpers/dimesns_helper.dart';
import 'package:dio_clean_architecture/helpers/font_helper.dart';
import 'package:dio_clean_architecture/helpers/storage_helper.dart';
import 'package:dio_clean_architecture/models/current_weather.dart';
import 'package:dio_clean_architecture/screens/auth_screens/location_screen.dart';
import 'package:dio_clean_architecture/screens/home_screen/save_location_popup.dart';
import 'package:dio_clean_architecture/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import '../../cubit/current_weather/current_weather_cubit.dart';
import '../../cubit/user_profile/user_profile_cubit.dart';
import '../../helpers/string_helper.dart';
import '../../utils/loading_indicator.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime time = DateTime.now();

  @override
  void initState() {
   context.read<CurrentWeatherCubit>().currentWeather(StorageHelper().getUserLat().toString(), StorageHelper().getUserLng().toString());
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsHelper.primaryColor,
        title: const Text(StringHelper.weather),

        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
          BlocProvider(
              create: (BuildContext context) => UserProfileCubit(),
              child: const ProfileScreen())));},
            icon:const CircleAvatar(
                backgroundColor: ColorsHelper.secondaryColor,
                child: Icon(Icons.person, color: ColorsHelper.whiteColor,))),

          actions: [
            IconButton(
                onPressed: ()async{
             var param = await Navigator.push(context, MaterialPageRoute(builder: (context)=> const LocationScreen(isPreviousScreenHome: true,)));

             if(param != null){
               saveAddressPopup(context,param['lat'], param['lng']);
               context.read<CurrentWeatherCubit>().currentWeather(param['lat'].toString(), param['lng'].toString());
             }

            },
                icon: const CircleAvatar(
                backgroundColor: ColorsHelper.whiteColor,
                child: Icon(Icons.location_on, color: ColorsHelper.secondaryColor,)))
          ],

      ),


      body: BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
          builder: (context, state) {
            if(state is CurrentWeatherLoading){
              return Center(child: loadingIndicator(color: ColorsHelper.secondaryColor),);
            }else if (state is CurrentWeatherError){
              return const Center(child: Text(StringHelper.somethingWentWrong),);
            }else if (state is CurrentWeatherLoaded){
              return contentWidget(state.currentWeatherModel, state.address);
            }
            return const SizedBox();
          }
      ),

    );
  }

  Widget contentWidget(CurrentWeatherModel currentWeatherModel, String address) {
    return Center(
      child: Column(
        children: [

          const SizedBox(height: DimensHelper.dimens_100,),


          Text(address,
          style: const TextStyle(color: ColorsHelper.secondaryColor, fontWeight: FontHelper.bold, fontSize: FontHelper.dimens_30),),

          Text(Jiffy.now().yMMMMEEEEdjm,
            style: const TextStyle(color: ColorsHelper.blackColor, fontWeight: FontHelper.regular, fontSize: FontHelper.dimens_20),),

          const SizedBox(height: DimensHelper.dimens_50,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: DimensHelper.dimens_100,
                width: DimensHelper.dimens_100,
                child: Image.asset(AssetsHelper.weatherIcon),
              ),

              Text("${currentWeatherModel.currentWeather?.temperature.toString()??""} ${currentWeatherModel.currentWeatherUnits?.temperature.toString()}",
                style: const TextStyle(color: ColorsHelper.secondaryColor, fontWeight: FontHelper.bold, fontSize: FontHelper.dimens_50),),

            ],
          ),

          const SizedBox(height: DimensHelper.dimens_20,),

           Text("Wind Speed: ${currentWeatherModel.currentWeather?.windspeed.toString()??""} ${currentWeatherModel.currentWeatherUnits?.windspeed.toString()??""}",
            style: const TextStyle(color: ColorsHelper.blackColor, fontWeight: FontHelper.medium, fontSize: FontHelper.dimens_20),),


        ],
      ),
    );
  }


}
