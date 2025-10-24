import 'package:flutter/material.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/features/auth/model/user_model.dart';
import 'package:workspace/features/admin/task/add_employee_task.dart';
import 'package:workspace/features/admin/screen/employee_detail.dart';
import 'package:workspace/features/admin/service/employee_service.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key, this.role = 'employee'});
  final String role;

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
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
      appBar: AdminAppBar(title: 'Employee List'),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: fetchEmployees,
          child: ListView(
            padding: EdgeInsets.all(25),
            children: [
              if (isLoading)
                Center(child: CircularProgressIndicator())
              else if (employees.isEmpty)
                Center(child: Text('No employees found.'))
              else
                ...employees.map((employee) {
                  return EmployeItem(
                    employee: employee,
                    onTap: () {
                      AppNavigator.push(
                        context,
                        EmployeeDetailPage(userModel: employee),
                      );
                    },
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeItem extends StatelessWidget {
  const EmployeItem({super.key, required this.employee, this.onTap});
  final UserModel employee;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.only(bottom: 15),
        child: ListTile(
          title: Text(
            employee.name ?? '',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Row(
                children: [
                  _buildItem(Icons.business_center, '${employee.position}'),
                  _buildItem(Icons.public_outlined, '${employee.department}'),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  _buildItem(Icons.email_outlined, '${employee.email}'),
                  _buildItem(Icons.phone_android_outlined, '${employee.phone}'),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      AppNavigator.push(
                        context,
                        AddEmployeeTaskPage(user: employee),
                      );
                    },
                    child: Text('Add Task'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Live Location'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(IconData key, String value) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(key, size: 18),
          SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
