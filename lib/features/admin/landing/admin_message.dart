import 'package:flutter/material.dart';
import 'package:workspace/core/components/app_bar.dart';

class AdminMessagePage extends StatefulWidget {
  const AdminMessagePage({super.key});

  @override
  State<AdminMessagePage> createState() => _AdminMessagePageState();
}

class _AdminMessagePageState extends State<AdminMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Report Page', hasBackButton: false),
      body: Center(child: Text('Admin Report Page')),
    );
  }
}
