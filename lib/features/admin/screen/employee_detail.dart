import 'package:flutter/material.dart';
import 'package:workspace/core/utils/app_colors.dart';
import 'package:workspace/core/utils/app_images.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/core/components/app_button.dart';
import 'package:workspace/features/auth/model/user_model.dart';
import 'package:workspace/core/components/app_network_image.dart';
import 'package:workspace/features/admin/task/add_employee_task.dart';
import 'package:workspace/features/admin/task/employee_task_list.dart';
import 'package:workspace/features/admin/attendance/employee_attendance.dart';
import 'package:workspace/features/admin/attendance/employee_attendace_list.dart';

class EmployeeDetailPage extends StatefulWidget {
  const EmployeeDetailPage({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> {
  bool showPassword = false;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    user = widget.userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        title: 'Profile',
        onBackTap: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 50),
                height: MediaQuery.of(context).size.height * 0.18,
                color: AppColors.secondary,
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(150),
                    ),
                    child: AppCachedImage(AppImages.demoAvaterURL, radius: 100),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              user?.name ?? '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Center(child: Text(user?.position ?? 'N/A')),
          SizedBox(height: 20),
          _buildItem('First Name', user?.name ?? 'N/A'),
          _buildDivider(),
          _buildItem('Last Name', user?.name ?? 'N/A'),
          _buildDivider(),
          InkWell(
            onTap: () async {
              setState(() => showPassword = !showPassword);
              await Future.delayed(const Duration(seconds: 3));
              setState(() => showPassword = false);
            },
            child: _buildItem(
              'Password',
              showPassword ? user?.password ?? '' : '*********',
            ),
          ),
          _buildDivider(),
          _buildItem('Position', user?.position ?? 'N/A'),
          _buildDivider(),
          _buildItem('Department', user?.department ?? 'N/A'),
          _buildDivider(),
          _buildItem('Birthday', 'N/A'),
          _buildDivider(),
          _buildItem('Personal E-mail', user?.email ?? 'N/A'),
          _buildDivider(),
          _buildItem('Company E-mail', user?.email ?? 'N/A'),
          SizedBox(height: 40),
          Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: AdminButton(
                  text: 'Add Task',
                  onTap: () {
                    AppNavigator.push(context, AddEmployeeTaskPage(user: user));
                  },
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: AdminButton(
                  text: 'See Tasks',
                  onTap: () {
                    AppNavigator.push(context, EmployeeTaskList(user: user));
                  },
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: AdminButton(
                  text: 'Assign Attendance',
                  onTap: () {
                    AppNavigator.push(
                      context,
                      AddEmployeeAttendancePage(user: user),
                    );
                  },
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: AdminButton(
                  text: 'See Attendance',
                  onTap: () {
                    AppNavigator.push(
                      context,
                      EmployeeAttendaceList(user: user),
                    );
                  },
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: AdminButton(
                  text: 'Send Message',
                  onTap: () {
                    AppNavigator.push(context, AddEmployeeTaskPage(user: user));
                  },
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: AdminButton(
                  text: 'See Messages',
                  onTap: () {
                    AppNavigator.push(context, AddEmployeeTaskPage(user: user));
                  },
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      height: 1,
      width: double.maxFinite,
      color: AppColors.grey,
      margin: EdgeInsets.symmetric(horizontal: 40),
    );
  }

  Padding _buildItem(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(key, style: TextStyle(color: AppColors.grey)),
          Text(value, style: TextStyle(color: AppColors.grey)),
        ],
      ),
    );
  }
}
