import 'package:flutter/material.dart';
import 'package:workspace/core/utils/app_colors.dart';

class AppStyles {
  AppStyles._();

  static const TextStyle mediumGrey12 = TextStyle(
    fontSize: 12,
    color: AppColors.grey,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle mediumGrey = TextStyle(
    color: AppColors.grey,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle headerText = TextStyle(
    fontSize: 24,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
  );
}
