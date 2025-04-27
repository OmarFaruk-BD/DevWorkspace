import 'package:flutter/material.dart';

class AppPopup {
  void show({
    required Widget widget,
    bool dismissible = true,
    required BuildContext context,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierColor: Colors.black.withAlpha(125),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation1, animation2) => widget,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
    );
  }

  void showFlip({
    required Widget widget,
    bool dismissible = true,
    required BuildContext context,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierColor: Colors.black.withAlpha(125),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation1, animation2) => widget,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionBuilder: (context, a1, a2, widget) {
        return Rotation3DTransition(
          turns: Tween<double>(begin: 3.1416, end: 6.2832).animate(
            CurvedAnimation(
              parent: a1,
              curve: const Interval(
                0.0,
                1.0,
                curve: Curves.linear,
              ),
            ),
          ),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: a1,
                curve: const Interval(
                  0.5,
                  1.0,
                  curve: Curves.elasticOut,
                ),
              ),
            ),
            child: widget,
          ),
        );
      },
    );
  }

  void approval({
    String? title,
    String? description,
    required BuildContext context,
    required VoidCallback onApprove,
  }) {
    showFlip(
      context: context,
      widget: ApprovalWidget(
        title: title,
        onApprove: onApprove,
        description: description,
      ),
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

class ApprovalWidget extends StatelessWidget {
  const ApprovalWidget({
    super.key,
    this.title,
    this.description,
    required this.onApprove,
  });
  final String? title;
  final String? description;
  final VoidCallback onApprove;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.black),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title ?? '',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (title != null) const SizedBox(height: 15),
              if (description != null) Text(description ?? ''),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: onApprove,
                    child: const Text('Yes'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
