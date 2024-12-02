import 'dart:ui';

import 'package:flutter/material.dart';

class ColorsHelper {
  static final ColorsHelper _singleton = ColorsHelper._internal();
  factory ColorsHelper() {return _singleton;}
  ColorsHelper._internal();


  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color primaryColor = Color(0xFFB3E5FC);
  static const Color secondaryColor = Color(0xFF4FC3F7);
}