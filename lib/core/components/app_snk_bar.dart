import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:workspace/core/utils/app_colors.dart';

class AppSnkBar {
  static void show(
    context,
    text, {
    int seconds = 4,
    String? actionText,
    bool isError = false,
    VoidCallback? onAction,
  }) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: isError ? AppColors.red : AppColors.primary,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: seconds),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
              if (actionText != null) const SizedBox(width: 10),
              if (actionText != null)
                InkWell(
                  onTap: onAction,
                  child: Text(
                    actionText,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
  }

  static void flushbar(
    BuildContext context,
    String? message, {
    String? title,
    int seconds = 4,
    String? actionText,
    bool isError = false,
    VoidCallback? onAction,
  }) {
    Flushbar(
      title: title,
      message: message,
      titleColor: AppColors.white,
      messageColor: AppColors.white,
      margin: const EdgeInsets.all(8),
      animationDuration: Durations.long1,
      duration: Duration(seconds: seconds),
      forwardAnimationCurve: Curves.easeIn,
      reverseAnimationCurve: Curves.easeOut,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8),
      backgroundColor: isError ? AppColors.red : AppColors.primary,
      mainButton:
          actionText == null
              ? null
              : InkWell(
                onTap: onAction,
                child: Text(
                  actionText,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
    ).show(context);
  }
}
