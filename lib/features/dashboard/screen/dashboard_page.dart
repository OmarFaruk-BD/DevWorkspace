import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workspace/core/utils/app_colors.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/core/utils/app_images.dart';
import 'package:workspace/features/dashboard/screen/leave_approval.dart';
import 'package:workspace/features/dashboard/screen/leave_request.dart';
import 'package:workspace/features/dashboard/widget/time_widget.dart';
import 'package:workspace/features/history/screen/attendance_detail.dart';
import 'package:workspace/features/history/screen/attendance_history.dart';
import 'package:workspace/features/home/widget/header.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.55),
                Row(
                  children: [
                    DashboardItem(
                      text: 'Today\'s\nOverview',
                      icon: AppImages.overview,
                      onTap:
                          () => AppNavigator.push(
                            context,
                            AttendanceDetailPage(isLanding: false),
                          ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    DashboardItem(
                      text: 'Attendance\nHistory',
                      icon: AppImages.overview_2,
                      onTap:
                          () => AppNavigator.push(
                            context,
                            AttendanceHistoryPage(),
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    DashboardItem(
                      text: 'Leave\nRequest',
                      icon: AppImages.overview_2,
                      onTap:
                          () => AppNavigator.push(context, LeaveRequestPage()),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    DashboardItem(
                      text: 'Leave\nApproval',
                      icon: AppImages.overview_2,
                      onTap: () => AppNavigator.push(context, LeaveApproval()),
                    ),
                  ],
                ),
              ],
            ),
          ),
          HeaderWidget(),
          TimeWidget(),
        ],
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  const DashboardItem({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });
  final String text;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color: AppColors.grey.withAlpha(150),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.red.withAlpha(100)),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF2F2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SvgPicture.asset(icon),
                ),
                SizedBox(height: 12),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
