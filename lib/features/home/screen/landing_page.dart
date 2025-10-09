import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:workspace/core/utils/app_colors.dart';
import 'package:workspace/core/utils/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:workspace/features/area/screen/area_page.dart';
import 'package:workspace/features/home/screen/home_page.dart';
import 'package:workspace/features/dashboard/screen/dashboard_page.dart';
import 'package:workspace/features/history/screen/attendance_detail.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, this.index});
  final int? index;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _index = 0;

  static const List<Widget> _screens = <Widget>[
    HomePage(),
    AreaPage(),
    AttendanceDetailPage(),
    DashboardPage(),
  ];

  @override
  void initState() {
    super.initState();
    _index = widget.index ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 18, right: 18, bottom: 24),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBottomNavBar2(
                icon: AppImages.home,
                label: context.tr('home'),
                isSelected: _index == 0,
                onTap: () => setState(() => _index = 0),
              ),
              _buildBottomNavBar2(
                icon: AppImages.location,
                label: context.tr('area'),
                isSelected: _index == 1,
                onTap: () => setState(() => _index = 1),
              ),
              _buildBottomNavBar2(
                icon: AppImages.calander,
                label: context.tr('history'),
                isSelected: _index == 2,
                onTap: () => setState(() => _index = 2),
              ),
              _buildBottomNavBar2(
                icon: AppImages.dashboard,
                label: context.tr('dashboard'),
                isSelected: _index == 3,
                onTap: () => setState(() => _index = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar2({
    required String icon,
    required String label,
    required bool isSelected,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? AppColors.secondary : Colors.transparent,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: isSelected ? 15 : 18,
              height: isSelected ? 15 : 18,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.white : AppColors.white,
                BlendMode.srcIn,
              ),
            ),
            if (isSelected) const SizedBox(width: 8),
            if (isSelected)
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
