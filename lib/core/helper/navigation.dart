import 'package:flutter/material.dart';

class AppNavigator {
  static const Duration _duration = Duration(milliseconds: 300);

  static void pushTo(
    BuildContext context,
    Widget widget, {
    VoidCallback? onBack,
  }) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (context) => widget),
    ).then((value) => onBack?.call());
  }

  static void push(BuildContext context, Widget widget) {
    Navigator.push<void>(
      context,
      PageRouteBuilder(
        transitionDuration: _duration,
        reverseTransitionDuration: _duration,
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // return FadeTransition(opacity: animation, child: child);
          // return ScaleTransition(scale: animation, child: child);

          final tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
          final curve = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );
          return SlideTransition(position: tween.animate(curve), child: child);
        },
      ),
    );
  }

  static void pushAndRemoveUntil(BuildContext context, Widget widget) {
    Navigator.of(context).pushAndRemoveUntil<void>(
      PageRouteBuilder(
        transitionDuration: _duration,
        reverseTransitionDuration: _duration,
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
          final curve = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );
          return SlideTransition(position: tween.animate(curve), child: child);
        },
      ),
      (Route<dynamic> route) => false,
    );
  }
}
