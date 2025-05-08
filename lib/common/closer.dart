import 'package:finance_news/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Closer extends StatelessWidget {
  const Closer({Key? key, this.onPress}) : super(key: key);

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress ?? () => Navigator.pop(context),
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: getSvg(
          svg: 'close',
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
