import 'package:flutter/material.dart';
import 'package:workspace/core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.actions,
    required this.title,
    this.hasBackButton = true,
  });

  final String title;
  final bool hasBackButton;
  final List<Widget>? actions;

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: actions,
      centerTitle: true,
      shadowColor: AppColors.white,
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      automaticallyImplyLeading: hasBackButton,
      leading:
          hasBackButton
              ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
                onPressed: () => Navigator.pop(context),
              )
              : const SizedBox(),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      ),
    );
  }
}
