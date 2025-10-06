import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImageView extends StatelessWidget {
  const AppImageView(
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

  String? get _mimeType =>
      fileName.contains('.') ? fileName.split('.').last.toLowerCase() : null;

  ColorFilter? get _colorFilter =>
      color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn);

  Widget get _defaultIcon =>
      Icon(Icons.error_outline, color: color, size: width);

  @override
  Widget build(BuildContext context) {
    switch (_mimeType) {
      case "svg":
        return SvgPicture.asset(
          fileName,
          width: width,
          height: height,
          colorFilter: _colorFilter,
          placeholderBuilder: (context) => _defaultIcon,
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
          errorBuilder: (context, error, stackTrace) => _defaultIcon,
        );
      default:
        return _defaultIcon;
    }
  }
}
