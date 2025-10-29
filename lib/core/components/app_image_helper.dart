// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AppImageHelper {
  final Logger _logger = Logger();

  /// Compresses an image to ≤ [maxSizeInBytes] and returns Base64 string
  Future<String?> compressImageToBase64(File? file) async {
    try {
      if (file == null) return null;
      final fileSize = await file.length();

      // 🔸 Step 1: Reject images larger than 2 MB
      const maxInputSize = 2 * 1024 * 1024; // 2 MB
      if (fileSize > maxInputSize) return null;

      final dir = await getTemporaryDirectory();
      final targetPath = path.join(
        dir.path,
        'compressed_${path.basename(file.path)}',
      );

      int quality = 90;
      File? compressedFile;

      // 🔸 Step 2: Keep compressing until under 500 KB or quality hits 30
      const targetMaxSize = 500 * 1024; // 500 KB
      while (true) {
        final result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path,
          targetPath,
          quality: quality,
        );

        if (result == null) return null;

        compressedFile = File(result.path);
        final size = await compressedFile.length();

        if (size <= targetMaxSize || quality <= 30) {
          break;
        }

        quality -= 10;
      }

      // 🔸 Step 3: Convert to Base64
      final bytes = await compressedFile.readAsBytes();
      final base64String = base64Encode(bytes);

      _logger.i(
        '✅ Image compressed successfully: '
        '${(await compressedFile.length() / 1024).toStringAsFixed(2)} KB',
      );

      return base64String;
    } catch (e) {
      _logger.e('Image compression error: $e');
      return null;
    }
  }

  /// Converts a base64 string to an Image widget
  static Widget base64ToImage(
    String base64String, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    try {
      Uint8List bytes = base64Decode(base64String);
      return Image.memory(
        bytes,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, color: Colors.red, size: 50);
        },
      );
    } catch (e) {
      debugPrint('Error decoding Base64 image: $e');
      return const Icon(Icons.error, color: Colors.red, size: 50);
    }
  }

  /// Converts base64 string to bytes (if needed for other logic)
  static Uint8List? base64ToBytes(String base64String) {
    try {
      return base64Decode(base64String);
    } catch (e) {
      debugPrint('Error decoding base64 to bytes: $e');
      return null;
    }
  }
}
