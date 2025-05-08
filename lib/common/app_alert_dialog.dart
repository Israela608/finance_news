import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  final Function() onConfirm;
  final Function()? onLeft;
  final String title;
  final String subtitle;
  final String buttonTitle;
  final String leftButtonTitle;
  final bool showCancel;

  const AppAlertDialog({
    super.key,
    required this.onConfirm,
    required this.title,
    required this.subtitle,
    this.buttonTitle = 'Confirm',
    this.leftButtonTitle = 'Cancel',
    this.showCancel = true,
    this.onLeft,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(subtitle),
      alignment: Alignment.center,
      actions: [
        if (showCancel) ...[
          ElevatedButton(
            onPressed: onLeft ?? () => Navigator.pop(context),
            child: Text(leftButtonTitle),
          ),
        ],
        ElevatedButton(
          onPressed: () => onConfirm(),
          child: Text(buttonTitle),
        ),
      ],
    );
  }
}
