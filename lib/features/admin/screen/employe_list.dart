import 'package:flutter/material.dart';
import 'package:workspace/core/helper/extention.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/features/admin/screen/employee_detail.dart';
import 'package:workspace/features/auth/model/user_model.dart';
import 'package:workspace/features/admin/service/employee_service.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key, this.role = 'employee'});
  final String role;

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  final EmployeeService _employeeService = EmployeeService();
  List<UserModel> employees = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    employees = await _employeeService.getAllEmployees(widget.role);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Employee List'),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(25),
          children: [
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (employees.isEmpty)
              Center(child: Text('No employees found.'))
            else
              ...employees.map((employee) {
                return InkWell(
                  onTap: () {
                    AppNavigator.push(
                      context,
                      EmployeeDetailPage(userModel: employee),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.only(bottom: 15),
                    child: ListTile(
                      title: Text(employee.name ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email: ${employee.email}'),
                          Text('Phone: ${employee.phone}'),
                          Text('Position: ${employee.position}'),
                          Text('Department: ${employee.department}'),
                          Text(
                            'Joined: ${employee.createdAt?.showDate() ?? ''}',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
