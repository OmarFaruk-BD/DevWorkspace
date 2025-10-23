import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/features/home/widget/header.dart';
import 'package:workspace/features/home/cubit/home_cubit.dart';
import 'package:workspace/features/home/widget/bottom_text.dart';
import 'package:workspace/features/home/widget/punch_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().updateMyArea(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [HeaderWidget(), PunchButton(), BottomSection()]),
    );
  }
}
