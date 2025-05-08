import 'package:flutter/material.dart';

@immutable
class AppColor {
  AppColor._();

  // Shades
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Text
  static const Color text50 = Color(0xFFFAFAFA);
  static const Color text400 = Color(0xFFA3A3A3);
  static const Color text500 = Color(0xFF737373);
  static const Color text900 = Color(0xFF171717);

  // Primary
  static const Color primary600 = Color(0xFF523AE4);

  // Secondary
  static const Color secondary50 = Color(0xFFF9FAFB);

  // Muted
  static const Color muted50 = Color(0xFFFAFAFA);
  static const Color muted300 = Color(0xFFD4D4D4);

  // Error Colors
  static const Color errorBase400 = Color(0xFFD42620);
  static const Color error500 = Color(0xFFCB1A14);
  static const Color error600 = Color(0xFFBA110B);
  static const Color error700 = Color(0xFF9E0A05);
  static const Color error800 = Color(0xFF800501);
  static const Color error900 = Color(0xFF800501);
}
