import 'package:assignment/core/utils/color_config.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData data = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: ColorConfig.primaryColor,
    useMaterial3: true,
  );
}
