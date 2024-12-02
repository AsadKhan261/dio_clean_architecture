import 'package:dio_clean_architecture/helpers/storage_helper.dart';
import 'package:dio_clean_architecture/screens/auth_screens/splash_screen.dart';
import 'package:dio_clean_architecture/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/auto_complete_places/auto_complete_places_cubit.dart';
import 'cubit/current_weather/current_weather_cubit.dart';
import 'cubit/user_profile/user_profile_cubit.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHelper().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AutoCompletePlacesCubit()),
        BlocProvider(create: (BuildContext context) => CurrentWeatherCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        navigatorKey: navigatorKey,
        home: const SplashScreen(),
      ),
    );
  }
}
