import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetImageView extends StatelessWidget {
  const AssetImageView(
    this.fileName, {
    super.key,
    this.fit,
    this.color,
    this.width,
    this.height,
  });

  final BoxFit? fit;
  final Color? color;
  final double? width;
  final double? height;
  final String fileName;

  String? get mimeType =>
      fileName.contains('.') ? fileName.split('.').last.toLowerCase() : null;

  @override
  Widget build(BuildContext context) {
    return _getView();
  }

  Widget _getView() {
    switch (mimeType) {
      case "svg":
        return SvgPicture.asset(
          fileName,
          width: width,
          height: height,
          colorFilter:
              color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
          placeholderBuilder: (context) =>
              Icon(Icons.error_outline, color: color),
        );
      case "png":
      case "jpg":
      case "gif":
      case "jpeg":
        return Image.asset(
          fileName,
          color: color,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.error_outline, color: color, size: width),
        );
      default:
        return Icon(
          Icons.image_not_supported_outlined,
          size: width,
          color: color,
        );
    }
  }
}
