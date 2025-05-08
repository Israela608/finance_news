import 'package:finance_news/core/utils/app_colors.dart';
import 'package:finance_news/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlainTextField extends StatelessWidget {
  const PlainTextField({
    super.key,
    required this.textController,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    required this.textInputAction,
    this.maxLines,
    this.validatorCallback,
    this.onChangedCallback,
    this.onSavedCallback,
  });

  final TextEditingController textController;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? maxLines;
  final String? Function(String?)? validatorCallback;
  final Function(String)? onChangedCallback;
  final Function(String?)? onSavedCallback;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      validator: validatorCallback,
      onChanged: (text) {
        if (onChangedCallback != null) {
          onChangedCallback!(text);
        }
      },
      onSaved: onSavedCallback,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      style: AppStyle.bodyStyle(context),
      cursorColor: AppColor.muted300,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyle.hintStyle(context),
        contentPadding: EdgeInsets.symmetric(
          vertical: 8.h,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: AppColor.muted300), // Line when not focused
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.muted300), // Line when focused
        ),
        isDense: true,
      ),
    );
  }
}
