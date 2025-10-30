import 'package:flutter/material.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/core/components/app_popup.dart';
import 'package:workspace/core/components/app_button.dart';
import 'package:workspace/core/components/approval_popup.dart';
import 'package:workspace/features/admin/screen/add_employee.dart';
import 'package:workspace/features/admin/screen/employe_list.dart';
import 'package:workspace/features/admin/widget/employee_popup.dart';
import 'package:workspace/features/admin/task/add_employee_task.dart';
import 'package:workspace/features/admin/task/employee_task_list.dart';
import 'package:workspace/features/admin/screen/admin_login_page.dart';
import 'package:workspace/features/admin/screen/manager_list_page.dart';
import 'package:workspace/features/admin/service/admin_auth_service.dart';
import 'package:workspace/features/admin/attendance/employee_attendance.dart';
import 'package:workspace/features/admin/attendance/e_attendance_history.dart';
import 'package:workspace/features/admin/notification/e_emergency_request.dart';
import 'package:workspace/features/admin/attendance/employee_location_list.dart';
import 'package:workspace/features/admin/notification/add_employee_notification.dart';
import 'package:workspace/features/admin/notification/employee_notification_list.dart';

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
      appBar: AdminAppBar(title: 'Admin Dashboard', hasBackButton: false),
      body: ListView(
        padding: EdgeInsets.all(25),
        children: [
          AdminButton(
            text: 'Add Employee',
            onTap: () => AppNavigator.push(context, AddEmployeePage()),
          ),
          SizedBox(height: 20),
          AdminButton(
            text: 'Employee List',
            onTap: () => AppNavigator.push(context, EmployeeListPage()),
          ),
          SizedBox(height: 20),
          AdminButton(
            text: 'Manager List',
            onTap: () => AppNavigator.push(context, ManagerListPage()),
          ),
          SizedBox(height: 20),
          AdminButton(
            text: 'Assign Task',
            onTap: () async {
              await AppPopup.show(
                child: EmployeePopup(
                  onSelected: (employee) {
                    if (!mounted) return;
                    AppNavigator.push(
                      context,
                      AddEmployeeTaskPage(user: employee),
                    );
                  },
                ),
                context: context,
              );
            },
          ),
          SizedBox(height: 20),
          AdminButton(
            text: 'See Assigned Task',
            onTap: () async {
              await AppPopup.show(
                child: EmployeePopup(
                  onSelected: (employee) {
                    if (!mounted) return;
                    AppNavigator.push(
                      context,
                      EmployeeTaskList(user: employee),
                    );
                  },
                ),
                context: context,
              );
            },
          ),
          SizedBox(height: 20),
          AdminButton(
            text: 'Assign Location',
            onTap: () async {
              await AppPopup.show(
                child: EmployeePopup(
                  onSelected: (employee) {
                    if (!mounted) return;
                    AppNavigator.push(
                      context,
                      AddEmployeeAttendancePage(user: employee),
                    );
                  },
                ),
                context: context,
              );
            },
          ),
          SizedBox(height: 20),
          AdminButton(
            text: 'See Assigned Location',
            onTap: () async {
              await AppPopup.show(
                child: EmployeePopup(
                  onSelected: (employee) {
                    if (!mounted) return;
                    AppNavigator.push(
                      context,
                      EmployeeLocationList(user: employee),
                    );
                  },
                ),
                context: context,
              );
            },
          ),
          SizedBox(height: 20),
          AdminButton(
            text: 'Attendance History',
            onTap: () async {
              await AppPopup.show(
                child: EmployeePopup(
                  onSelected: (employee) {
                    if (!mounted) return;
                    AppNavigator.push(
                      context,
                      EAttendanceHistory(user: employee),
                    );
                  },
                ),
                context: context,
              );
            },
          ),
          SizedBox(height: 20),
          AdminButton(
            text: 'Emergency Request List',
            onTap: () async {
              await AppPopup.show(
                child: EmployeePopup(
                  onSelected: (employee) {
                    if (!mounted) return;
                    AppNavigator.push(
                      context,
                      EEmergencyRequest(user: employee),
                    );
                  },
                ),
                context: context,
              );
            },
          ),
          SizedBox(height: 20),
          AdminButton(
            text: 'Send Notification',
            onTap: () async {
              await AppPopup.show(
                child: EmployeePopup(
                  onSelected: (employee) {
                    if (!mounted) return;
                    AppNavigator.push(
                      context,
                      AddEmployeeNotificationPage(user: employee),
                    );
                  },
                ),
                context: context,
              );
            },
          ),
          SizedBox(height: 20),
          AdminButton(
            text: 'See Notifications',
            onTap: () async {
              await AppPopup.show(
                child: EmployeePopup(
                  onSelected: (employee) {
                    if (!mounted) return;
                    AppNavigator.push(
                      context,
                      EmployeeNotificationList(user: employee),
                    );
                  },
                ),
                context: context,
              );
            },
          ),
          SizedBox(height: 20),
          AdminButton(text: 'Sign Out', onTap: _signOut),
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
