import 'package:finance_news/common/app_alert_dialog.dart';
import 'package:finance_news/common/show_custom_snackbar.dart';
import 'package:finance_news/core/helper/navigation.dart';
import 'package:finance_news/core/utils/app_colors.dart';
import 'package:finance_news/core/utils/app_styles.dart';
import 'package:finance_news/core/utils/extensions.dart';
import 'package:finance_news/core/utils/utils.dart';
import 'package:finance_news/modules/screens/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class AllowNotificationsScreen extends StatelessWidget {
  const AllowNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary50,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            234.height,
            getSvg(
              svg: 'message-notif',
              height: 98,
              width: 98,
            ),
            24.height,
            Text(
              'Get the most out of Blott ✅',
              style: AppStyle.titleStyleSmall(context),
            ),
            16.height,
            Text(
              'Allow notifications to stay in the loop with your payments, requests and groups.',
              style: AppStyle.subtitleStyle(context),
            ),
            Spacer(),
            ContinueButton(),
            48.height,
          ],
        ),
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          await Permission.notification.request();

          final notificationStatus = await Permission.notification.status;

          if (notificationStatus == PermissionStatus.denied ||
              notificationStatus == PermissionStatus.permanentlyDenied) {
            if (context.mounted) {
              await showDialog(
                context: context,
                builder: (context) => AppAlertDialog(
                  onConfirm: () async => await openAppSettings(),
                  title: 'Notification Permission',
                  subtitle:
                      'Notification permission should Be granted to use this feature, would you like to go to app settings to allow Notifications?',
                ),
              );
            }
          } else {
            return Navigation.gotoWidget(
              context,
              replacePreviousScreen: true,
              NewsScreen(),
            );
          }
        } catch (e) {
          showCustomSnackBar(
            context,
            message: 'Permission to send notifications denied!',
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.primary600,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Center(
          child: Text(
            'Continue',
            style: AppStyle.buttonTextStyle(context),
          ),
        ),
      ),
    );
  }
}
