import 'package:flutter/material.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/core/components/app_button.dart';
import 'package:workspace/features/admin/screen/add_employee.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Admin Dashboard', hasBackButton: false),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(25),
          children: [
            AppButton(
              text: 'Dashboard',
              onTap: () => AppNavigator.push(context, AddEmployeePage()),
            ),
            SizedBox(height: 20),
            AppButton(
              text: 'Add Employee',
              onTap: () => AppNavigator.push(context, AddEmployeePage()),
            ),
            SizedBox(height: 20),
            AppButton(text: 'Area Management', onTap: () {}),
            SizedBox(height: 20),
            AppButton(text: 'Assign Task', onTap: () {}),
            SizedBox(height: 20),
            AppButton(text: 'Notification', onTap: () {}),
            SizedBox(height: 20),
            AppButton(text: 'Report', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
