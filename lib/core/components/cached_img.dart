import 'package:flutter/material.dart';
import 'package:workspace/core/components/app_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedNetImg extends StatelessWidget {
  const CachedNetImg(
    this.url, {
    this.fit,
    super.key,
    this.width,
    this.height,
    this.demoUrl,
    this.radius = 0,
    this.errorWidget,
  });

  final String? url;
  final BoxFit? fit;
  final double? width;
  final double radius;
  final double? height;
  final String? demoUrl;
  final Widget? errorWidget;

  String? get effectiveUrl => url ?? demoUrl;

  @override
  Widget build(BuildContext context) {
    return effectiveUrl == null || effectiveUrl!.isEmpty
        ? _buildErrorWidget()
        : _buildImage();
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: effectiveUrl!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        placeholder: (context, url) => AppShimmer(
          height: height,
          width: width,
        ),
        errorWidget: (context, url, error) => _buildErrorWidget(),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: errorWidget ??
          Icon(
            Icons.image,
            color: Colors.grey,
            size: width != null ? width! * 0.5 : 24,
          ),
    );
  }
}
