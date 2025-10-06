import 'package:flutter/material.dart';

class AppPopup {
  static Future<void> show({
    required Widget child,
    bool dismissible = true,
    required BuildContext context,
  }) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierColor: Colors.black.withAlpha(125),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation1, animation2) => child,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(opacity: a1.value, child: widget),
        );
      },
    );
  }

  static Future<void> showFlip({
    required Widget child,
    bool dismissible = true,
    required BuildContext context,
  }) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierColor: Colors.black.withAlpha(125),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation1, animation2) => child,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionBuilder: (context, a1, a2, widget) {
        return Rotation3DTransition(
          turns: Tween<double>(begin: 3.1416, end: 6.2832).animate(
            CurvedAnimation(
              parent: a1,
              curve: const Interval(0.0, 1.0, curve: Curves.linear),
            ),
          ),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: a1,
                curve: const Interval(0.5, 1.0, curve: Curves.elasticOut),
              ),
            ),
            child: widget,
          ),
        );
      },
    );
  }
}

class Rotation3DTransition extends AnimatedWidget {
  const Rotation3DTransition({
    super.key,
    this.child,
    required Animation<double> turns,
  }) : super(listenable: turns);

  final Widget? child;
  Animation<double> get turns => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0006)
        ..rotateY(turns.value),
      alignment: const FractionalOffset(0.5, 0.5),
      child: child,
    );
  }
}
