import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFieldIcon extends StatelessWidget {
  const TextFieldIcon({
    super.key,
    this.onTap,
    required this.icon,
  });
  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: SvgPicture.asset(
            icon,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
