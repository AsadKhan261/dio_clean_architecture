import 'package:dio_clean_architecture/helpers/colors_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator ({Color? color}) {
  return CircularProgressIndicator(color: color??ColorsHelper.whiteColor,);
}