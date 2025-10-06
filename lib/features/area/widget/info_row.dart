import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workspace/core/utils/app_images.dart';
import 'package:workspace/core/utils/app_colors.dart';
import 'package:workspace/core/components/app_text.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            SvgPicture.asset(AppImages.search),
            CommonText('09:08 AM', fontWeight: FontWeight.w600),
            CommonText('Punch In', color: AppColors.grey),
          ],
        ),
        Column(
          children: [
            SvgPicture.asset(AppImages.search),
            CommonText('08:13 ', fontWeight: FontWeight.w600),
            CommonText('Total Hours', color: AppColors.grey),
          ],
        ),
        Column(
          children: [
            SvgPicture.asset(AppImages.search),
            CommonText('--:--', fontWeight: FontWeight.w600),
            CommonText('Punch Out', color: AppColors.grey),
          ],
        ),
      ],
    );
  }
}
