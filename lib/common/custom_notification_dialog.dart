import 'package:finance_news/common/closer.dart';
import 'package:finance_news/core/utils/app_colors.dart';
import 'package:finance_news/core/utils/app_styles.dart';
import 'package:finance_news/core/utils/extensions.dart';
import 'package:finance_news/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNotificationDialog extends HookWidget {
  const CustomNotificationDialog({
    Key? key,
    required this.title,
    required this.description,
    this.isError = true,
    this.isSnackBar = false,
    this.onPress,
    this.onCancelPress,
  }) : super(key: key);

  final String title;
  final String description;
  final bool isError;
  final bool isSnackBar;
  final VoidCallback? onPress;
  final VoidCallback? onCancelPress;

  @override
  Widget build(BuildContext context) {
    final showDialog = useState<bool>(false);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 200), () {
        showDialog.value = true;
      });

      return null;
    }, []);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Matrix4.translationValues(
          0, showDialog.value ? 20.h : -MediaQuery.of(context).size.height, 0),
      curve: Curves.easeInOut,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: CustomDialog(
          title: title,
          description: description,
          isError: isError,
          onPress: () {
            onPress?.call();
            showDialog.value = false;
          },
          onCancelPress: () {
            onCancelPress?.call();
            showDialog.value = false;
            if (Navigator.canPop(context) && !isSnackBar)
              Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.isError,
    this.onPress,
    this.onCancelPress,
  }) : super(key: key);

  final String title;
  final String description;
  final bool isError;
  final VoidCallback? onPress;
  final VoidCallback? onCancelPress;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.topCenter,
      insetPadding: EdgeInsets.only(top: 30.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: GestureDetector(
        onTap: onPress,
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isError ? AppColor.error50 : AppColor.success50,
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(
                    width: 1.h,
                    color: AppColor.grey200,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    22.width,
                    Container(
                      height: 24.h,
                      width: 24.w,
                      margin: EdgeInsets.only(top: 4.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          width: 1.h,
                          color:
                              isError ? AppColor.error75 : AppColor.success75,
                        ),
                      ),
                      child: Center(
                        child: getSvg(
                          svg: 'check-circle',
                          height: 12,
                          width: 12,
                          color: isError ? null : AppColor.successBase400,
                        ),
                      ),
                    ),
                    12.width,
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: robotoStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.grey900,
                            ),
                          ),
                          2.height,
                          Text(
                            description,
                            style: robotoStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.grey600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    61.width,
                  ],
                )),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 6.w,
                decoration: BoxDecoration(
                  color: isError ? AppColor.error500 : AppColor.success500,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.r),
                    bottomLeft: Radius.circular(4.r),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 8.w,
              top: 0,
              bottom: 0,
              child: Closer(
                onPress: onCancelPress,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
