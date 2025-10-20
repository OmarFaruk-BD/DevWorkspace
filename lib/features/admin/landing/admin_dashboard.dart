import 'package:flutter/material.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/core/components/app_popup.dart';
import 'package:workspace/core/components/app_button.dart';
import 'package:workspace/core/components/approval_popup.dart';
import 'package:workspace/features/admin/screen/add_employee.dart';
import 'package:workspace/features/admin/screen/employe_list.dart';
import 'package:workspace/features/admin/screen/admin_login_page.dart';
import 'package:workspace/features/admin/service/admin_auth_service.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  final AdminAuthService _service = AdminAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Admin Dashboard', hasBackButton: false),
      body: ListView(
        padding: EdgeInsets.all(25),
        children: [
          AppButton(
            text: 'Add Employee',
            onTap: () => AppNavigator.push(context, AddEmployeePage()),
          ),
          SizedBox(height: 20),
          AppButton(
            text: 'Employee List',
            onTap: () => AppNavigator.push(context, EmployeeList()),
          ),
          SizedBox(height: 20),
          AppButton(
            text: 'Manager List',
            onTap: () =>
                AppNavigator.push(context, EmployeeList(role: 'admin')),
          ),
          SizedBox(height: 20),
          AppButton(text: 'Area Management', onTap: () {}),
          SizedBox(height: 20),
          AppButton(text: 'Assign Task', onTap: () {}),
          SizedBox(height: 20),
          AppButton(text: 'Notification', onTap: () {}),
          SizedBox(height: 20),
          AppButton(text: 'Report', onTap: () {}),
          SizedBox(height: 20),
          AppButton(text: 'Sign Out', onTap: _signOut),
        ],
      ),
    );
  }

  void _signOut() async {
    AppPopup.show(
      context: context,
      child: ApprovalWidget(
        title: 'Sign Out',
        description: 'Are you sure you want to sign out?',
        onApprove: () async {
          await _service.signOut();
          if (!mounted) return;
          AppNavigator.pushAndRemoveUntil(context, const AdminLoginPage());
        },
      ),
    );
  }
}
