import 'package:flutter/cupertino.dart';

class FontHelper {
  static final FontHelper _singleton = FontHelper._internal();
  factory FontHelper() {return _singleton;}
  FontHelper._internal();

  static const double dimens_10 = 10.0;
  static const double dimens_12 = 12.0;
  static const double dimens_14 = 14.0;
  static const double dimens_16 = 16.0;
  static const double dimens_18 = 18.0;
  static const double dimens_20 = 20.0;
  static const double dimens_25 = 25.0;
  static const double dimens_30 = 30.0;
 static const double dimens_50 = 50.0;


  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.bold;

}