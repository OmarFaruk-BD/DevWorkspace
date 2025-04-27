import 'package:flutter/material.dart';
import 'package:workspace/core/utils/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    this.btnColor,
    this.textColor,
    required this.text,
    this.hPadding = 15,
    this.vPadding = 15,
    this.textSize = 16,
    this.circular = 10,
    this.isLoading = false,
  });

  final String text;
  final bool isLoading;
  final double textSize;
  final double hPadding;
  final double vPadding;
  final Color? btnColor;
  final double circular;
  final Color? textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(circular),
        ),
        child: Center(
          child:
              isLoading
                  ? SizedBox(
                    width: textSize * 1.45,
                    height: textSize * 1.45,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: textColor ?? AppColors.white,
                      ),
                    ),
                  )
                  : Text(
                    text,
                    style: TextStyle(
                      fontSize: textSize,
                      fontWeight: FontWeight.w600,
                      color: textColor ?? AppColors.white,
                    ),
                  ),
        ),
      ),
    );
  }
}
