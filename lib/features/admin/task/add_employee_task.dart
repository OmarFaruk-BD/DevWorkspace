import 'package:flutter/material.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/features/auth/model/user_model.dart';

class AddEmployeeTaskPage extends StatefulWidget {
  const AddEmployeeTaskPage({super.key, this.user});
  final UserModel? user;

  @override
  State<AddEmployeeTaskPage> createState() => _AddEmployeeTaskPageState();
}

class _AddEmployeeTaskPageState extends State<AddEmployeeTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(title: 'Add Employee Task'),
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
