import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color mainColor = Color(0xFF06283D);
  static const Color primaryColor1 = Color(0xFF1363DF);
  static const Color primaryColor2 = Color(0xFF47B5FF);
  static const Color backgroundColor = Color(0xFFDFF6FF);
  static LinearGradient primaryGradient =const LinearGradient(
    colors: [
      AppColors.primaryColor2,
      AppColors.primaryColor1,
    ],
    // begin: Alignment.bottomLeft,
    // end: Alignment.topRight,
  );
}
