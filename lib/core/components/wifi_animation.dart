import 'package:flutter/material.dart';

class WifiAnimation extends StatefulWidget {
  const WifiAnimation({
    super.key,
    this.size = 100,
    this.centered = true,
    this.color = Colors.grey,
  });

  final double size;
  final Color color;
  final bool centered;

  @override
  WifiAnimationState createState() => WifiAnimationState();
}

class WifiAnimationState extends State<WifiAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        6,
        (index) {
          return Container(
            width: widget.size,
            height: widget.size,
            padding: EdgeInsets.all(index * (widget.size / 10)),
            child: ShapesState(
              index: index,
              color: widget.color,
              controller: _controller,
              centered: widget.centered,
            ),
          );
        },
      ),
    );
  }
}

class ShapesState extends AnimatedWidget {
  const ShapesState({
    super.key,
    required this.index,
    required this.color,
    required this.centered,
    required AnimationController controller,
  }) : super(listenable: controller);

  final int index;
  final bool centered;
  final Color color;

  Animation<double> get controller => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DrawShapes(index, centered, controller.value),
    );
  }
}

class DrawShapes extends CustomPainter {
  DrawShapes(
    this.index,
    this.centered,
    this.controller,
  );
  final int index;
  final bool centered;
  final double controller;

  @override
  void paint(Canvas canvas, Size size) {
    Color color = Colors.red.withAlpha(25);
    if ((4 - index) == ((controller * 5).toInt())) {
      color = Colors.red;
    }

    Paint brush = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    var startArc = (225 * 3.14) / 180;
    var endArc = (90 * 3.14) / 180;

    //make the first as a circle
    if (index == 0 && centered) {
      brush.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(size.height / 2, size.width / 2), 5, brush);
    } else {
      brush.style = PaintingStyle.stroke;
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.height / 2, size.width / 2),
          height: size.height,
          width: size.width,
        ),
        startArc,
        endArc,
        false,
        brush,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
