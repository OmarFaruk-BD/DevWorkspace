import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:workspace/core/utils/app_colors.dart';

class ItemSelectionField extends StatelessWidget {
  const ItemSelectionField({
    super.key,
    this.icon,
    this.text,
    this.onTap,
    this.radius = 6,
  });

  final String? icon;
  final String? text;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: AppColors.grey),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text ?? '',
                style: const TextStyle(color: AppColors.black),
              ),
            ),
            if (icon != null) const SizedBox(width: 8),
            if (icon != null) SvgPicture.asset(icon!, width: 16, height: 16),
          ],
        ),
      ),
    );
  }
}
