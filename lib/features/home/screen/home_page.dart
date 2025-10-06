import 'package:flutter/material.dart';
import 'package:workspace/features/home/widget/header.dart';
import 'package:workspace/features/home/widget/bottom_text.dart';
import 'package:workspace/features/home/widget/punch_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [HeaderWidget(), PunchButton(), BottomSection()]),
    );
  }
}
