import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class AppImagePicker {
  void pickImage({
    Function(File?)? onImagePick,
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          maintainBottomViewPadding: true,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 150),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 40,
                ),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(
                      text: 'Camera',
                      icon: Icons.camera,
                      onTap: () => _pickAndCropImage(
                        ImageSource.camera,
                        context,
                        onImagePick,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(height: 50, width: 1, color: Colors.white),
                    const SizedBox(width: 20),
                    _buildButton(
                      text: 'Gallery',
                      icon: Icons.photo_library,
                      onTap: () => _pickAndCropImage(
                        ImageSource.gallery,
                        context,
                        onImagePick,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickAndCropImage(
    ImageSource source,
    BuildContext context,
    Function(File?)? onImagePick,
  ) async {
    Navigator.pop(context);

    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.greenAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Crop Image'),
      ],
    );

    if (croppedFile != null) {
      onImagePick?.call(File(croppedFile.path));
    } else {
      onImagePick?.call(null);
    }
  }

  Widget _buildButton({
    VoidCallback? onTap,
    required String text,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 5),
          SizedBox(
            width: 100,
            child: Center(
              child: Text(text, style: const TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
