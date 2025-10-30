import 'package:flutter/material.dart';
import 'package:workspace/core/helper/extention.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/core/components/app_snack_bar.dart';
import 'package:workspace/features/auth/model/user_model.dart';
import 'package:workspace/features/dashboard/model/task_model.dart';
import 'package:workspace/features/admin/service/employee_service.dart';
import 'package:workspace/features/admin/service/employee_task_service.dart';

class MyTaskDetail extends StatefulWidget {
  const MyTaskDetail({super.key, required this.task});
  final TaskModel task;

  @override
  State<MyTaskDetail> createState() => _MyTaskDetailState();
}

class _MyTaskDetailState extends State<MyTaskDetail> {
  final EmployeeTaskService _taskService = EmployeeTaskService();
  final EmployeeService _employeeService = EmployeeService();
  bool isLoading = false;
  late TaskModel task;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    task = widget.task;
    initLoadData();
  }

  void initLoadData() async {
    user = await _employeeService.getEmployeeDetail(task.assignedTo);
    setState(() {});
  }

  void geTaskDetail() async {
    final getTask = await _taskService.getTaskByEmployeeAndIdV2(
      assignedTo: task.assignedTo,
      taskId: task.taskId,
    );
    if (getTask != null) {
      task = getTask;
    }
    setState(() {});
  }

  void deleteTask() async {
    setState(() => isLoading = true);
    final result = await _taskService.deleteTask(task.taskId);
    setState(() => isLoading = false);
    result.fold((error) => AppSnackBar.show(context, error), (data) {
      AppSnackBar.show(context, data);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(title: 'Task Detail'),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          if (user != null) _EmployeItem(user!),
          TaskDetailItem(task: task),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}

class TaskDetailItem extends StatelessWidget {
  const TaskDetailItem({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Card(
        child: ListTile(
          title: Text('Task Detail:'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(task.description),
              SizedBox(height: 4),
              Text('Status: ${task.status}'),
              SizedBox(height: 4),
              Text('Due Date: ${task.dueDate}'),
              SizedBox(height: 4),
              Text('Priority: ${task.priority}'),
              SizedBox(height: 4),
              Text('Task Type: ${task.taskType}'),
              SizedBox(height: 4),
              Text('Schedule: ${task.comments}'),
              SizedBox(height: 4),
              Text('Client: ${task.client}'),
              SizedBox(height: 4),
              Text('Amount: ${task.amount}'),
              SizedBox(height: 4),
              Text('Created At: ${task.createdAt.toDateString()}'),
              SizedBox(height: 4),
              Text('Updated At: ${task.updatedAt.toDateString()}'),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmployeItem extends StatelessWidget {
  const _EmployeItem(this.employee);
  final UserModel employee;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Card(
        child: ListTile(
          title: Text('Assigned To:'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.name ?? '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
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
          Expanded(
            child: Text(
              value,
              maxLines: 2,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
