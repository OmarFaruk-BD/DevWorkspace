import 'package:flutter/material.dart';
import 'package:workspace/core/components/app_bar.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(title: 'Admin Home Page', hasBackButton: false),
      body: Center(child: Text('Admin Home Page')),
    );
  }
}
