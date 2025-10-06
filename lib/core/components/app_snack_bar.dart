import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:workspace/core/utils/app_colors.dart';

class AppSnackBar {
  static void show(
    BuildContext context,
    String text, {
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
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: seconds),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: isError ? AppColors.red : AppColors.green,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  onAction != null
                      ? onAction.call()
                      : ScaffoldMessenger.of(context).removeCurrentSnackBar();
                },
                child: Text(
                  actionText ?? 'OK',
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

  static void error(BuildContext context, String text, {int seconds = 5}) {
    show(context, text, seconds: seconds, isError: true);
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
      animationDuration: Durations.short4,
      duration: Duration(seconds: seconds),
      forwardAnimationCurve: Curves.easeIn,
      reverseAnimationCurve: Curves.easeOut,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8),
      backgroundColor: isError ? AppColors.red : AppColors.green,
      mainButton: InkWell(
        onTap: () {
          onAction != null ? onAction.call() : Navigator.pop(context);
        },
        child: Text(
          actionText ?? 'OK  ',
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ).show(context);
  }
}
