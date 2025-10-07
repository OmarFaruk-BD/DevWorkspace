import 'package:flutter/material.dart';
import 'package:workspace/core/utils/app_images.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/features/admin/screen/admin_login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLandingPage();
  }

  void _navigateToLandingPage() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    AppNavigator.pushAndRemoveUntil(context, const AdminLoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset(AppImages.icon, height: 200, width: 200)),
    );
  }
}
