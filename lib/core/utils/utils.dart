import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

String getSvgPath(String svg) {
  return 'assets/svgs/$svg.svg';
}

String getImagePath(String image) {
  return 'assets/images/$image.png';
}

Widget getSvg({
  required String svg,
  required double? height,
  required double? width,
  BoxFit? fit,
  Color? color,
  VoidCallback? onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: SvgPicture.asset(
      getSvgPath(svg),
      height: height?.h,
      width: width?.w,
      fit: fit ?? BoxFit.contain,
      color: color,
    ),
  );
}

Widget getImage({
  required String image,
  required double? height,
  required double? width,
  BoxFit? fit,
  Color? color,
  VoidCallback? onPressed,
}) {
  return FittedBox(
    fit: fit ?? BoxFit.scaleDown,
    child: InkWell(
      onTap: onPressed,
      child: Image.asset(
        getImagePath(image),
        height: height?.h,
        width: width?.w,
        // fit: fit ?? BoxFit.contain,
        color: color,
      ),
    ),
  );
}
