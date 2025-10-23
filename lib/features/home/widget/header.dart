import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/core/utils/app_colors.dart';
import 'package:workspace/core/utils/app_images.dart';
import 'package:workspace/core/utils/app_styles.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/core/components/app_text.dart';
import 'package:workspace/features/auth/cubit/auth_cubit.dart';
import 'package:workspace/features/home/screen/notification.dart';
import 'package:workspace/features/home/screen/profile_page.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 15,
              bottom: 85,
              right: 20,
              left: 20,
            ),
            color: AppColors.primary,
            child: Row(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: Icon(Icons.person, size: 40, color: AppColors.primary),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        state.user?.name ?? '',
                        maxLines: 2,
                        fontSize: 18,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        state.user?.phone ?? '',
                        style: AppStyles.mediumGrey12.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      AppNavigator.push(context, NotificationPage()),
                  icon: SvgPicture.asset(AppImages.notification),
                ),
                IconButton(
                  onPressed: () => AppNavigator.push(context, ProfilePage()),
                  icon: SvgPicture.asset(AppImages.menu),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
