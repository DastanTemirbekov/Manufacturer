/* External dependencies */
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/* Local dependencies */
import 'package:test_project/internal/helpers/text_helper.dart';
import 'package:test_project/internal/helpers/theme_helper.dart';

class Exceptions {
  static showFlushbar(
    String message, {
    required BuildContext context,
  }) {
    Flushbar(
      backgroundColor: ThemeHelper.flashbarColor,
      borderRadius: BorderRadius.circular(10.r),
      margin: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 16.w,
      ),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      isDismissible: true,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 500),
      padding: EdgeInsets.symmetric(
        vertical: 24.h,
        horizontal: 24.w,
      ),
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextHelper.bold16.copyWith(color: ThemeHelper.white),
      ),
      mainButton: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.close,
          color: ThemeHelper.white,
        ),
      ),
    ).show(context);
  }
}
