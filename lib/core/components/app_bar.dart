import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:workspace/core/utils/app_colors.dart';
import 'package:workspace/core/utils/app_images.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/features/home/screen/profile_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.onBackTap,
    required this.title,
    this.hasMenuButton = true,
    this.hasBackButton = true,
  });

  final String title;
  final bool hasBackButton;
  final bool hasMenuButton;
  final VoidCallback? onBackTap;

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: [
        if (hasMenuButton)
          IconButton(
            icon: SvgPicture.asset(AppImages.search),
            onPressed: () => AppNavigator.push(context, ProfilePage()),
          ),
      ],
      centerTitle: true,
      shadowColor: Colors.white,
      backgroundColor: AppColors.red,
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: hasBackButton,
      leading:
          hasBackButton
              ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: onBackTap,
              )
              : const SizedBox(),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
