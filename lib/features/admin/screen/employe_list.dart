import 'package:flutter/material.dart';
import 'package:workspace/core/components/app_bar.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Employee List'),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(25),
          children: [
           
          ],
        ),
      ),
    );
  }
}
