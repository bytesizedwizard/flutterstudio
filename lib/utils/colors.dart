import 'package:flutter/material.dart';

class AppColors extends Color {
  
  final int colorCode;
  const AppColors(this.colorCode) : super(colorCode);
  
  static const AppColors primaryAppColor = const AppColors(0xFF003A60);
  static const AppColors secondaryAppColor = const AppColors(0xFF001320);
  static const AppColors primaryFontColor = const AppColors(0xFFFFFFFF);
}