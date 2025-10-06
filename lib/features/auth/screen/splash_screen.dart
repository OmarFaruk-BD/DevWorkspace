import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/features/auth/cubit/auth_cubit.dart';
import 'package:workspace/features/auth/screen/login_page.dart';
import 'package:workspace/features/auth/service/auth_service.dart';
import 'package:workspace/features/home/screen/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToLandingPage(context);
  }

  void navigateToLandingPage(BuildContext context) async {
    final result = await AuthService().getUserDetail();
    if (!context.mounted) return;
    result.fold(
      (l) => AppNavigator.pushAndRemoveUntil(context, const LoginPage()),
      (r) async {
        context.read<AuthCubit>().updateUser(r);
        await Future.delayed(const Duration(seconds: 1));
        if (!context.mounted) return;
        AppNavigator.pushAndRemoveUntil(context, const LandingPage());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/image/icon.png', width: 100, height: 100),
      ),
    );
  }
}
