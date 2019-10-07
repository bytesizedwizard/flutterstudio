import 'package:flutter/material.dart';

class AppColors extends Color {
  
  final int colorCode;
  const AppColors(this.colorCode) : super(colorCode);
  
  static const AppColors primaryColor = const AppColors(0xFF003A60);
  static const AppColors secondaryColor = const AppColors(0xFF001320);
  static const AppColors fontPrimaryColor = const AppColors(0xFFFFFFFF);
  static const AppColors transparent = const AppColors(0x00FFFFFF);
}