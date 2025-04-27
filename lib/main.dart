import 'package:flutter/material.dart';
import 'package:workspace/core/utils/app_theme.dart';
import 'package:workspace/features/landing/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeDataLight,
      home: const SplashScreen(),
    );
  }
}
