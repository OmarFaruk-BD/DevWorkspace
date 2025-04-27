import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({
    super.key,
    this.width,
    this.height,
  });
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }
}
