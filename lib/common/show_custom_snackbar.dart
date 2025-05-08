import 'dart:developer';

import 'package:finance_news/common/custom_notification_dialog.dart';
import 'package:flutter/material.dart';

void showCustomSnackBar(
  BuildContext context, {
  String title = 'Great!',
  required String message,
  bool isError = true,
  String logMessage = '',
}) {
  log('SNACKBAR LOG => ${logMessage.isNotEmpty ? logMessage : message}');

  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => CustomNotificationDialog(
      title: isError ? 'Error' : title,
      description: message,
      isError: isError,
      isSnackBar: true,
      onPress: () => null,
      onCancelPress: null,
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 4), () {
    overlayEntry.remove();
  });
}
