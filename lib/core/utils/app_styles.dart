import 'package:finance_news/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle robotoStyle({
  required double fontSize,
  required Color color,
  required FontWeight fontWeight,
  double? height,
  TextDecoration? decoration,
  Color? decorationColor,
  double? decorationThickness,
}) {
  return TextStyle(
    fontFamily: 'Roboto',
    fontSize: fontSize.sp,
    color: color,
    fontWeight: fontWeight,
    height: height?.h,
    decoration: decoration,
    decorationColor: decorationColor ?? color,
    decorationThickness: decorationThickness,
  );
}

TextStyle ralewayStyle({
  required double fontSize,
  required Color color,
  required FontWeight fontWeight,
  double? height,
  TextDecoration? decoration,
  Color? decorationColor,
  double? decorationThickness,
}) {
  return TextStyle(
    fontFamily: 'Raleway',
    fontSize: fontSize.sp,
    color: color,
    fontWeight: fontWeight,
    height: height?.h,
    decoration: decoration,
    decorationColor: decorationColor ?? color,
    decorationThickness: decorationThickness,
  );
}

TextStyle rubikStyle({
  required double fontSize,
  required Color color,
  required FontWeight fontWeight,
  double? height,
  TextDecoration? decoration,
  Color? decorationColor,
  double? decorationThickness,
}) {
  return TextStyle(
    fontFamily: 'Rubik',
    fontSize: fontSize.sp,
    color: color,
    fontWeight: fontWeight,
    height: height?.h,
    decoration: decoration,
    decorationColor: decorationColor ?? color,
    decorationThickness: decorationThickness,
  );
}

class AppStyle {
  static TextStyle? titleStyle(BuildContext context) => robotoStyle(
        color: AppColor.text900,
        fontSize: 30,
        fontWeight: FontWeight.w700,
      );

  static TextStyle? titleStyleSmall(BuildContext context) =>
      titleStyle(context)?.copyWith(fontSize: 24.sp);

  static TextStyle? titleStyleWhite(BuildContext context) => ralewayStyle(
        color: AppColor.white,
        fontSize: 32,
        fontWeight: FontWeight.w900,
      );

  static TextStyle? subtitleStyle(BuildContext context) => robotoStyle(
        color: AppColor.text500,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  static TextStyle? bodyStyle(BuildContext context) => robotoStyle(
        color: AppColor.text900,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      );

  static TextStyle? hintStyle(BuildContext context) =>
      bodyStyle(context)?.copyWith(color: AppColor.text400);

  static TextStyle? buttonTextStyle(BuildContext context) => robotoStyle(
        color: AppColor.text50,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  static TextStyle? bodyWhiteSmallStyle(BuildContext context) => rubikStyle(
        color: AppColor.white,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );

  static TextStyle? bodyWhiteSmallBig(BuildContext context) => robotoStyle(
        color: AppColor.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      );

  static TextStyle? errorStyle(BuildContext context) => rubikStyle(
        color: AppColor.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );
}
