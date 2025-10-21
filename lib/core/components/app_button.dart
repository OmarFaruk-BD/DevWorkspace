import 'package:flutter/material.dart';
import 'package:workspace/core/utils/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    this.width,
    this.btnColor,
    this.textColor,
    this.radius = 16,
    required this.text,
    this.hPadding = 15,
    this.vPadding = 15,
    this.textSize = 16,
    this.isLoading = false,
  });

  final String text;
  final double? width;
  final double radius;
  final bool isLoading;
  final double textSize;
  final double hPadding;
  final double vPadding;
  final Color? btnColor;
  final Color? textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
        decoration: BoxDecoration(
          color: btnColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  width: textSize * 1.45,
                  height: textSize * 1.45,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: textColor ?? AppColors.white,
                  ),
                ),
              )
            : Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.w700,
                  color: textColor ?? AppColors.white,
                ),
              ),
      ),
    );
  }
}

class AdminButton extends AppButton {
  const AdminButton({
    super.key,
    super.onTap,
    super.width,
    super.textColor,
    super.radius = 16,
    required super.text,
    super.hPadding = 15,
    super.vPadding = 15,
    super.textSize = 16,
    super.isLoading = false,
    super.btnColor = AppColors.admin,
  });
}
