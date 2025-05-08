import 'package:finance_news/core/utils/app_colors.dart';
import 'package:finance_news/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Center(
        child: getImage(
          image: 'launch_image',
          height: 188.h,
          width: 188.w,
        ),
      ),
    );
  }
}
