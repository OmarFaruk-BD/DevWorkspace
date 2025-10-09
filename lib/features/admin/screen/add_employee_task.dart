import 'package:flutter/material.dart';
import 'package:workspace/core/components/app_bar.dart';

class AddEmployeeTask extends StatefulWidget {
  const AddEmployeeTask({super.key});

  @override
  State<AddEmployeeTask> createState() => _AddEmployeeTaskState();
}

class _AddEmployeeTaskState extends State<AddEmployeeTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Employee Task'),
      body: ListView(
        children: [
          Center(child: Text('Under Development')),
          Center(child: Text('Under Development')),
          Center(child: Text('Under Development')),
          Center(child: Text('Under Development')),
        ],
      ),
    );
  }
}
