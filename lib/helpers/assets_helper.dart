class AssetsHelper {
  static final AssetsHelper _singleton = AssetsHelper._internal();
  factory AssetsHelper() {return _singleton;}
  AssetsHelper._internal();


  static const String weatherIcon = "assets/weather_icon.png";
}