import 'package:flutter/material.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/features/auth/model/user_model.dart';

class MyShopVisitPage extends StatefulWidget {
  const MyShopVisitPage({super.key, this.user});
  final UserModel? user;

  @override
  State<MyShopVisitPage> createState() => _MyShopVisitPageState();
}

class _MyShopVisitPageState extends State<MyShopVisitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Shop Visit'),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text('My Shop Visit'),
          Text('My Shop Visit'),
          Text('My Shop Visit'),
        ],
      ),
    );
  }
}
