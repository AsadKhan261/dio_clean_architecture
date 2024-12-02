import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/colors_helper.dart';
import '../helpers/dimesns_helper.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onPress;
  final Widget child;
  const CommonButton({super.key, required this.onPress, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DimensHelper.dimens_50,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorsHelper.secondaryColor
          ),
          child: child),

    );
  }
}
